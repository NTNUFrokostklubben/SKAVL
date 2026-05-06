
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/theme/colors.dart';

/// Status overview box to display number of remaining images to classify.
///
/// Can be expanded to contain more information if needed.
class ClassificationOverviewBox extends StatelessWidget {
  const ClassificationOverviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final projectManager = context.watch<ProjectManagerService>();
    final unclassified = projectManager.loadedProject?.unclassifiedAnomaliesInRange.length;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColors.grey.withAlpha(200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "${loc.overviewWidget_remaining}: $unclassified",
      ),
    );
  }

}