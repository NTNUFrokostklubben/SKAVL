import 'package:flutter/material.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/widgets/autocomplete_dropdown.dart';

class ConfirmAnomalyDialog extends StatefulWidget {
  const ConfirmAnomalyDialog({super.key});

  @override
  State<ConfirmAnomalyDialog> createState() => _ConfirmAnomalyDialog();

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ConfirmAnomalyDialog(),
    );
  }
}

class _ConfirmAnomalyDialog extends State<ConfirmAnomalyDialog> {

  // TODO: how do we make the dropdown options dynamic when the users add new anomaly types in terms of language? 

  List<String> anomalyTypes = [
    'Type 1',
    'Type 2',
    'Type 3',
    'Type 4',
  ];

  String? selectedAnomaly;

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(loc()!.anomalyClassifBar_confirm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: SizedBox(
        width: 500,
        height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${loc()!.confirmAnomaly_imageName} : HX-123-456'),
            const SizedBox(height: 20),

            Text(
              loc()!.anomalyClassifBar_anomalyType,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            AutocompleteDropdown(
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
          child: const Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: () {
            if (selectedAnomaly == null || selectedAnomaly!.trim().isEmpty) {
              return;
            }
            Navigator.of(context).pop(selectedAnomaly);
          },
          style: TextButton.styleFrom(
            foregroundColor: MyColors.secondaryBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
