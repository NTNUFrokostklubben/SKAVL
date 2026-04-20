import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/entity/anomaly_def.dart';
import 'package:skavl/pages/analysis.dart';
import 'package:skavl/services/project_file_service.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/util/navigation_util.dart';
import 'package:skavl/widgets/bottom_status_bar.dart';
import 'package:skavl/widgets/labels/fieldlabels.dart';
import 'package:skavl/widgets/labels/headings.dart';

import '../entity/anomaly_set.dart';
import '../l10n/app_localizations.dart';
import '../proto/anomaly.pb.dart' as proto;
import '../services/anomaly_service_provider.dart';
import '../theme/colors.dart';
import '../widgets/top_bar.dart';

class ProjectOverview extends StatefulWidget {
  const ProjectOverview({super.key});

  @override
  State<ProjectOverview> createState() => _ProjectOverviewState();
}

class _ProjectOverviewState extends State<ProjectOverview> {
  proto.DescribeAnomalyProjectResponse? _projectInfo;
  bool _isLoading = true;

  /// Run entire analysis from data and parses it to project file.
  ///
  /// Will need to do incremental writes eventually to allow partial project completion.
  Future<void> _startAnomalyDetection(
      ProjectManagerService projectManager,) async {
    final imagePath = projectManager.loadedProject!.imageFolderPath;
    final sosiPath = projectManager.loadedProject!.sosiFilePath;

    context
        .read<AnomalyServiceProvider>()
        .controller
        .runAnalysis(
        projectName: projectManager.loadedProject!.projectName,
        imagePath: imagePath,
        sosiPath: sosiPath,
        waterSosiPath: projectManager.loadedProject!.sosiWaterMaskPath!
    )
        .then((response) {
      final sets = response.anomalyResponse.anomalySets
          .map(
            (s) =>
            AnomalySet(
              imageName: s.imageName,
              anomalyConf: s.anomalyConfidence,
              lineNumber: s.lineNumber,
              imageNumber: s.imageNumber,
              anomalyDef: AnomalyDef.undefined,
            ),
      )
          .toList();

      final updated = projectManager.loadedProject!.copyWith(allSets: sets);
      projectManager.setProject(updated, projectManager.filePath!);
      ProjectFileService().saveToFile(projectManager.filePath!, updated);
    });
  }

  Future<void> _testProgress() async {
    final projectManager = context.read<ProjectManagerService>();
    final result = await context
        .read<AnomalyServiceProvider>()
        .controller
        .getProgress(projectName: projectManager.loadedProject!.projectName);
    print(result);
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

  @override
  Widget build(BuildContext context) {
    ProjectManagerService projectManager = context
        .read<ProjectManagerService>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: TopBar(foreignContext: context),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 32,
          children: [
            LargeHeader("Project overview"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 32,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      LargeLabel("${loc!.projectOverview_projectName}:"),
                      Text(projectManager.loadedProject!.projectName),

                      LargeLabel("${loc.createPage_uploadPlaneImages}:"),
                      Text(projectManager.loadedProject!.imageFolderPath),

                      LargeLabel("${loc.createPage_uploadSOSIFile}:"),
                      Text(projectManager.loadedProject!.sosiFilePath),

                      LargeLabel("${loc.createPage_uploadWaterSOSIFile}:"),
                      Text(
                        projectManager.loadedProject?.sosiWaterMaskPath != null
                            ? projectManager.loadedProject!.sosiWaterMaskPath!
                            : loc.projectOverview_noWaterSosi,
                      ),
                    ],
                  ),
                  if (!_isLoading)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LargeLabel("${loc.projectOverview_imagesPresent}:"),
                        Text(_projectInfo!.imagesInFolder.toString()),

                        LargeLabel("${loc.projectOverview_imagesProcessed}:"),
                        Text(
                          projectManager.loadedProject!.allSets.length
                              .toString(),
                        ),

                        LargeLabel(
                          "${loc.projectOverview_lastImageProcessed}:",
                        ),
                        Text(
                          projectManager.loadedProject!.allSets.isEmpty
                              ? loc.g_noImagesProcessed
                              : projectManager
                              .loadedProject!
                              .allSets[_projectInfo!.lastProcessedImage]
                              .imageName,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            Spacer(),
            // Run analysis button
            Row(
              spacing: 18,
              children: [
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => _startAnomalyDetection(projectManager),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          loc.projectOverview_runAnalysis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => navigateTo(context, Analysis()),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          loc.projectOverview_classifyImages,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Theme
                              .of(context)
                              .brightness == Brightness.light
                              ? MyColors.secondaryBlack
                              : MyColors.primaryWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => _testProgress(),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Test progress fetch",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        )
                      ],
                    ),
                  ),
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
