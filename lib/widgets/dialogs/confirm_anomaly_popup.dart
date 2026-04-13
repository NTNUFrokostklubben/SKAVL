import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
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

  // TODO: how do we make the dropdown options dynamic when the users add new anomaly types in terms of language?

  List<String> anomalyTypes = ['Type 1', 'Type 2', 'Type 3', 'Type 4'];

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
                  setState(() => _selectedDef = set.first);
                },
              ),
            ),

            SizedBox(height: 4),
            Text(
              loc()!.anomalyClassifBar_anomalyType,
              style: Theme.of(context).textTheme.titleSmall,
            ),

            AutocompleteDropdown(
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
          onPressed: () {
            final text = _classificationController.text.trim();
            if (text.isEmpty) return;
            Navigator.of(context).pop(
              AnomalyClassification(
                anomalyDef: _selectedDef,
                userClassification: text,
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
