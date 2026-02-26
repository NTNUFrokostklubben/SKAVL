import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/model/settings_model.dart';
import 'package:skavl/widgets/labels/headings.dart';
import 'package:skavl/widgets/top_bar.dart';

import '../l10n/app_localizations.dart';

/// Settings page for changing global settings in the application
/// Uses the settings model to store the actual settings values
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    AppLocalizations? loc() {
      return AppLocalizations.of(context);
    }

    List<DropdownMenuEntry> languageEntries = [
      DropdownMenuEntry<Locale?>(value: Locale('en'), label: loc()!.g_enloc),
      DropdownMenuEntry<Locale?>(value: Locale('nb'), label: loc()!.g_nbloc),
    ];

    List<DropdownMenuEntry> modeEntries = [
      DropdownMenuEntry<ThemeMode>(value: ThemeMode.dark, label: loc()!.settings_darkMode),
      DropdownMenuEntry<ThemeMode>(value: ThemeMode.light, label: loc()!.settings_lightMode),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Fix styling, maybe use a title component or something idk
            LargeHeader(
                loc()!.settings_title
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 48,
                children: [
                  SizedBox(width: 80, child: Text(loc()!.settings_language, style: Theme.of(context).textTheme.bodyMedium)),
                  DropdownMenu(
                    width: 400,
                    dropdownMenuEntries: languageEntries,
                    initialSelection: settings.locale,
                    onSelected: (v) {
                      context.read<SettingsModel>().setLocale(v);
                    },
                  ),
                ],
              ),
            ),

            LargeHeader(loc()!.settings_theme),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 48,
              children: [
                SizedBox(width: 80, child: Text(loc()!.settings_theme,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                DropdownMenu(
                width: 400,
                dropdownMenuEntries: modeEntries,
                initialSelection: settings.theme,
                onSelected: (v) {
                  context.read<SettingsModel>().setTheme(v);
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
