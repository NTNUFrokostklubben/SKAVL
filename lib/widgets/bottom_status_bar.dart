import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/services/project_manager_service.dart';

import 'package:skavl/l10n/app_localizations.dart';

/// Status bar to show if a project is loaded in the application or not
///
/// Only used for displaying information to the user
class BottomStatusBar extends StatelessWidget {
  const BottomStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectManagerService projectManagerService = context
        .watch<ProjectManagerService>();
    final loc = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 2),
        Container(
          height: 24,
          color: Theme.of(context).appBarTheme.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerLeft,
          child: Text(
            projectManagerService.hasProject
                ? "${loc!.g_project}: ${projectManagerService.loadedProject!.projectName}"
                : "${loc!.g_project}: none",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
