import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/services/project_manager_service.dart';

import '../l10n/app_localizations.dart';
import '../theme/colors.dart';

class BottomStatusBar extends StatelessWidget {
  final BuildContext foreignContext;

  const BottomStatusBar({super.key, required this.foreignContext});

  AppLocalizations? loc() {
    return AppLocalizations.of(foreignContext);
  }

  @override
  Widget build(BuildContext context) {
    ProjectManagerService projectManagerService = context.watch<ProjectManagerService>();

    // TODO: implement build
    return Column(
      children: [
        Divider(height: 1, thickness: 2),
        Container(
          height: 24,
          color: Theme.of(context).appBarTheme.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerLeft,
          child: Text(projectManagerService.hasProject ? "Project: ${projectManagerService.loadedProject!.projectName}" : "Project: none", style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
