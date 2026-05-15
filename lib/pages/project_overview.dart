import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/controller/report_generation_controller.dart';
import 'package:skavl/entity/analysis_progress.dart';
import 'package:skavl/entity/anomaly_def.dart';
import 'package:skavl/entity/anomaly_set.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/pages/analysis.dart';
import 'package:skavl/proto/anomaly.pb.dart' as proto;
import 'package:skavl/proto/anomaly.pbenum.dart';
import 'package:skavl/services/anomaly_service_provider.dart';
import 'package:skavl/services/project_file_service.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/util/anomaly_helpers.dart';
import 'package:skavl/util/navigation_util.dart';
import 'package:skavl/widgets/bottom_status_bar.dart';
import 'package:skavl/widgets/dialogs/loading_popup.dart';
import 'package:skavl/widgets/labels/headings.dart';
import 'package:skavl/widgets/top_bar.dart';

class ProjectOverview extends StatefulWidget {
  const ProjectOverview({super.key});

  @override
  State<ProjectOverview> createState() => _ProjectOverviewState();
}

class _ProjectOverviewState extends State<ProjectOverview> {
  proto.DescribeAnomalyProjectResponse? _projectInfo;
  bool _isLoading = true;

  /// Run entire analysis from data based on [ProjectManagerService] and [StartMode].
  ///
  /// Supports two start modes:
  /// - Start from scratch (START_RESTART)
  /// - Continue previous analysis as stored in the Anomaly Service database (START_CONTINUE).
  Future<void> _startAnomalyDetection(
    ProjectManagerService projectManager, {
    proto.StartMode startMode = proto.StartMode.START_CONTINUE,
  }) async {
    final imagePath = projectManager.loadedProject!.imageFolderPath;
    final sosiPath = projectManager.loadedProject!.sosiFilePath;

    final ValueNotifier<AnalysisProgress> progress =
        ValueNotifier<AnalysisProgress>(AnalysisProgress(0, 0));

    final controller = context.read<AnomalyServiceProvider>().controller;

    LoadingDialog.show(context, progress: progress);

    controller.startPolling(
      projectName: projectManager.loadedProject!.projectName,
      progress: progress,
    );

    final navigator = Navigator.of(context, rootNavigator: true);

    controller
        .runAnalysis(
          projectName: projectManager.loadedProject!.projectName,
          imagePath: imagePath,
          sosiPath: sosiPath,
          waterSosiPath: projectManager.loadedProject!.sosiWaterMaskPath,
          startMode: startMode,
        )
        .then((response) {
          controller.stopPolling();
          navigator.pop();

          final sets = response.anomalyResponse.anomalySets
              .map(
                (s) => AnomalySet(
                  imageName: s.imageName,
                  anomalyConf: s.anomalyConfidence,
                  lineNumber: s.lineNumber,
                  imageNumber: s.imageNumber,
                  anomalyDef: AnomalyDef.undefined,
                ),
              )
              .toList();

          List<AnomalySet> newSets;
          if (startMode == proto.StartMode.START_RESTART) {
            newSets = sets;
          } else {
            newSets = mergeAnomalySets(
              projectManager.loadedProject!.allSets,
              sets,
            );
          }

          final updated = projectManager.loadedProject!.copyWith(
            allSets: newSets,
            currentPage: 0
          );
          projectManager.setProject(updated, projectManager.filePath!);
          ProjectFileService().saveToFile(projectManager.filePath!, updated);
        });
  }

  /// Dialog for starting analysis from scratch.
  ///
  /// Hidden under 3-dot menu on project overview page.
  Future<void> _confirmAndRestartAnalysis(
    ProjectManagerService projectManager,
  ) async {
    final loc = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: MediumHeader(loc!.projectOverview_startFromScratch),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.projectOverview_scratchDesc,
            ),
            Text(loc.projectOverview_scratchAreyousure, style: Theme.of(context).textTheme.titleSmall,),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: MyColors.secondaryBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(loc.g_cancel, style: Theme.of(ctx).textTheme.titleSmall),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: MyColors.primaryWhite,
            ),
            child: Text(
              loc.projectOverview_scratchConfirm,
              style: Theme.of(
                ctx,
              ).textTheme.titleSmall?.copyWith(color: MyColors.primaryWhite),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      _startAnomalyDetection(
        projectManager,
        startMode: proto.StartMode.START_RESTART,
      );
    }
  }

  Future<void> _loadProjectInfo() async {
    final projectManager = context.read<ProjectManagerService>();
    final result = await context
        .read<AnomalyServiceProvider>()
        .controller
        .getProjectInfo(
          projectName: projectManager.loadedProject!.projectName,
          imagePath: projectManager.loadedProject!.imageFolderPath,
          sosiPath: projectManager.loadedProject!.sosiFilePath,
        );

    setState(() {
      _projectInfo = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProjectInfo();
  }

  /// Generate classified report
  ///
  /// Uses loaded project to generate a unclassified report based on analysis.
  /// TODO: Move into separate controller
  Future<void> _generateReport() async {
    final projectManager = context.read<ProjectManagerService>();
    final reportController = ReportGenerationController();
    await reportController.generateUnclassifiedReport(
      projectMetadata: projectManager.loadedProject!,
      locale: AppLocalizations.of(context)!.localeName,
    );
  }

  /// Generate classified report
  ///
  /// Uses loaded project to generate a classified report based on user classifications.
  /// TODO: Move into separate controller
  Future<void> _generateReportClassified() async {
    final projectManager = context.read<ProjectManagerService>();
    final reportController = ReportGenerationController();
    await reportController.generateClassifiedReport(
      projectMetadata: projectManager.loadedProject!,
      locale: AppLocalizations.of(context)!.localeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final projectManager = context.read<ProjectManagerService>();
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: TopBar(foreignContext: context),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LargeHeader(loc.projectOverview_title),
                PopupMenuButton<String>(
                  popUpAnimationStyle: AnimationStyle.noAnimation,
                  icon: const Icon(Icons.more_vert),
                  onSelected: (v) {
                    if (v == "restart") {
                      _confirmAndRestartAnalysis(projectManager);
                    }
                  },
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      value: "restart",
                      child: Text("Start analysis from scratch"),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            _SectionCard(
              title: loc.projectOverview_projectDetails,
              child: Column(
                children: [
                  _FieldRow(
                    label: loc.projectOverview_projectName,
                    value: projectManager.loadedProject!.projectName,
                  ),
                  _FieldRow(
                    label: loc.createPage_uploadPlaneImages,
                    value: projectManager.loadedProject!.imageFolderPath,
                  ),
                  _FieldRow(
                    label: loc.createPage_uploadSOSIFile,
                    value: projectManager.loadedProject!.sosiFilePath,
                  ),
                  _FieldRow(
                    label: loc.createPage_uploadWaterSOSIFile,
                    value: projectManager.loadedProject?.sosiWaterMaskPath,
                    fallback: loc.projectOverview_noWaterSosi,
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            !_isLoading
                ? _SectionCard(
                    title: loc.projectOverview_progress,
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatCell(
                            label: loc.projectOverview_imagesPresent,
                            value: _projectInfo!.imagesInFolder.toString(),
                          ),
                        ),
                        _StatDivider(),
                        Expanded(
                          child: _StatCell(
                            label: loc.projectOverview_imagesProcessed,
                            value: projectManager.loadedProject!.allSets.length
                                .toString(),
                          ),
                        ),
                        _StatDivider(),
                        Expanded(
                          child: _StatCell(
                            label: loc.projectOverview_lastImageProcessed,
                            value: projectManager.loadedProject!.allSets.isEmpty
                                ? loc.g_noImagesProcessed
                                : projectManager
                                      .loadedProject!
                                      .allSets
                                      .last
                                      .imageName,
                          ),
                        ),
                      ],
                    ),
                  )
                : const Spacer(),

            const Spacer(),
            // Run analysis button and navigate to classification page button
            Stack(
              children: [
                // Report buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            projectManager
                                .loadedProject!
                                .unclassifiedAnomaliesInRange
                                .isEmpty
                            ? null
                            : () => _generateReport(),
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [Text(loc.projectOverview_unclassified)],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed:
                            projectManager
                                .loadedProject!
                                .classifiedAnomaliesInRange
                                .isEmpty
                            ? null
                            : () => _generateReportClassified(),
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [Text(loc.projectOverview_classified)],
                        ),
                      ),
                    ),
                  ],
                ),

                // Analysis buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => _startAnomalyDetection(projectManager),
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [Text(loc.projectOverview_runAnalysis)],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        // Disables button of no images have been analyzed yet
                        onPressed: projectManager.loadedProject!.allSets.isEmpty
                            ? null
                            : () => navigateTo(context, Analysis()),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(loc.projectOverview_classifyImages),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.light
                                  ? MyColors.secondaryBlack
                                  : MyColors.primaryWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStatusBar(),
    );
  }
}

/// Card widget for displaying a section in the overview page (e.g. project details, progress stats)
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: borderColor, width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                letterSpacing: 0.8,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: borderColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Field row (label + value in two columns) used in the project details section
class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    this.value,
    this.fallback,
    this.isLast = false,
  });

  final String label;
  final String? value;
  final String? fallback;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).dividerColor;
    final isMissing = value == null;

    return Container(
      decoration: isLast
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(color: borderColor, width: 0.5),
              ),
            ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isMissing ? (fallback ?? '—') : value!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isMissing
                    ? Theme.of(context).hintColor
                    : Theme.of(context).textTheme.bodyMedium!.color,
                fontStyle: isMissing ? FontStyle.italic : FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Cell widget for displaying a single stat (label + value) in the progress section
class _StatCell extends StatelessWidget {
  const _StatCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

///Thin vertical divider between stat cells
class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: VerticalDivider(
        width: 1,
        thickness: 0.5,
        color: Theme.of(context).dividerColor,
      ),
    );
  }
}
