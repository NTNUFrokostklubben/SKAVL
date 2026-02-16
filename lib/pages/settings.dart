import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';

import '../l10n/app_localizations.dart';

typedef MenuEntry = DropdownMenuEntry<String>;

const List<String> list = <String>['en', 'no'];

class Settings extends StatelessWidget {
  const Settings({
    super.key,
    required this.onLocaleChanged,
    required this.currentLocale,
  });

  final Locale? currentLocale;
  final ValueChanged<Locale?> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? loc() {
      return AppLocalizations.of(context);
    }

    List<DropdownMenuEntry> entries = [
      DropdownMenuEntry<Locale?>(value: Locale('en'), label: loc()!.g_enloc),
      DropdownMenuEntry<Locale?>(value: Locale('nb'), label: loc()!.g_nbloc),
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 48,
                children: [
                  SizedBox(width: 64, child: Text(loc()!.settings_language)),
                  DropdownMenu(
                    dropdownMenuEntries: entries,
                    initialSelection: currentLocale,
                    onSelected: (v) {
                      onLocaleChanged(v);
                    },
                  ),
                  Text(loc()!.openFormer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
