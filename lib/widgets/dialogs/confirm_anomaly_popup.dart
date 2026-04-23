import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/services/anomaly_type_history_service.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/widgets/autocomplete_dropdown.dart';
import 'package:skavl/widgets/labels/headings.dart';

import '../../entity/anomaly_classification.dart';
import '../../entity/anomaly_def.dart';

class ConfirmAnomalyDialog extends StatefulWidget {
  const ConfirmAnomalyDialog({super.key});

  @override
  State<ConfirmAnomalyDialog> createState() => _ConfirmAnomalyDialog();

  static Future<AnomalyClassification?> show(BuildContext context) {
    return showDialog<AnomalyClassification>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmAnomalyDialog(),
    );
  }
}

class _ConfirmAnomalyDialog extends State<ConfirmAnomalyDialog> {
  late final ProjectManagerService? _projectManager;
  late final TextEditingController _classificationController;
  late final FocusNode _classificationFocusNode;
  AnomalyDef _selectedDef = AnomalyDef.anomaly;

  List<String> anomalyTypes = [];

  String? selectedAnomaly;

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    _projectManager = context.read<ProjectManagerService>();
    final project = _projectManager?.loadedProject;
    if (project != null && project.anomaliesInRange.isNotEmpty) {
      final current = project.anomaliesInRange[project.currentPage];
      selectedAnomaly = current.userClassification;
      _selectedDef = current.anomalyDef == AnomalyDef.undefined
          ? AnomalyDef.anomaly
          : current.anomalyDef;
    }

    _classificationController = TextEditingController(
      text: selectedAnomaly ?? '',
    );
    _classificationFocusNode = FocusNode();

    _loadAnomalyTypes();
  }

  /// Fetches anomaly types from the history file to populate dropdown.
  Future<void> _loadAnomalyTypes() async {
    await AnomalyTypeHistoryService().load();
    if (mounted) {
      setState(() {
        anomalyTypes = AnomalyTypeHistoryService().anomalyTypes.toList();
      });
    }
  }

  @override
  void dispose() {
    _classificationController.dispose();
    _classificationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = _projectManager?.loadedProject;
    final imageName = project != null
        ? project.anomaliesInRange[project.currentPage].imageName
        : '';

    return AlertDialog(
      title: MediumHeader(loc()!.anomalyClassifBar_confirm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        width: 500,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              '${loc()!.confirmAnomaly_imageName} : $imageName',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            SizedBox(
              width: 350,
              child: SegmentedButton<AnomalyDef>(
                expandedInsets: EdgeInsets.zero,
                segments: [
                  ButtonSegment(
                    value: AnomalyDef.anomaly,
                    label: Text(loc()!.confirmAnomaly_anomaly),
                  ),
                  ButtonSegment(
                    value: AnomalyDef.noAnomaly,
                    label: Text(loc()!.confirmAnomaly_noAnomaly),
                  ),
                ],
                selected: {_selectedDef},
                onSelectionChanged: (set) {
                  final newValue = set.first;

                  setState(() {
                    _selectedDef = newValue;

                    if (_selectedDef == AnomalyDef.noAnomaly) {
                      _classificationController.clear();
                      selectedAnomaly = null;
                    }
                  });
                },
              ),
            ),

            SizedBox(height: 4),
            Text(
              loc()!.anomalyClassifBar_anomalyType,
              style: Theme.of(context).textTheme.titleSmall,
            ),

            Opacity(
              opacity: _selectedDef == AnomalyDef.noAnomaly ? 0.2 : 1,
              child: IgnorePointer(
                ignoring: _selectedDef == AnomalyDef.noAnomaly,
                child: AutocompleteDropdown(
                  controller: _classificationController,
                  focusNode: _classificationFocusNode,
                  options: anomalyTypes,

                  onSelected: (value) {
                    setState(() {
                      selectedAnomaly = value;
                    });
                  },

                  onCreate: (newValue) {
                    setState(() {
                      anomalyTypes.add(newValue);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),

          style: TextButton.styleFrom(
            foregroundColor: MyColors.secondaryBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            loc()!.g_cancel,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),

        ElevatedButton(
          onPressed: () async {
            final text = _classificationController.text.trim();
            if (text.isEmpty && _selectedDef == AnomalyDef.anomaly) return;
            if (_selectedDef==AnomalyDef.anomaly){
              await AnomalyTypeHistoryService().add(text);
            }
            if (!context.mounted) return;
            Navigator.of(context).pop(
              AnomalyClassification(
                anomalyDef: _selectedDef,
                userClassification: _selectedDef == AnomalyDef.noAnomaly ? null : text,
              ),
            );
          },
          child: Text(
            loc()!.g_confirm,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
