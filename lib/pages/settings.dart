import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/model/settings_model.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/widgets/top_bar.dart';

import '../l10n/app_localizations.dart';

/// Settings page for changing global settings in the application
/// Uses the settings model to store the actual settings values
class Settings extends StatelessWidget {
  const Settings({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    AppLocalizations? loc() {
      return AppLocalizations.of(context);
    }

    List<DropdownMenuEntry> entries = [
      DropdownMenuEntry<Locale?>(value: Locale('en'), label: loc()!.g_enloc),
      DropdownMenuEntry<Locale?>(value: Locale('nb'), label: loc()!.g_nbloc),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Fix styling, maybe use a title component or something idk
            Text(
              loc()!.settings_title,
              style: TextStyle(
                color: MyColors.secondaryBlack,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 48,
                children: [
                  SizedBox(width: 64,child: Text(loc()!.settings_language)),
                  DropdownMenu(
                    width: 400,
                    dropdownMenuEntries: entries,
                    initialSelection: settings.locale,
                    onSelected: (v) {
                      context.read<SettingsModel>().setLocale(v);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: TopBar(foreignContext: context),
    );
  }
}
