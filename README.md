# skavl

Main application for SKAVL

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



### l10n
Added i10n localization to the application. Currently main.dart provides an example of the syntax in scaffold for the title of the application.
app_en.arb and app_nb.arb both define localization strings, any new string must be added to both, description is necessary.
To get the functions for localization run "flutter gen-l10n". 

for the localization .arb files we use the structure of "identifier_string", where identifier prefix describes the scope of the localization string. "g_" prefix is used for global/generic. Description should reflect usage of word and be generic for generic strings, such as "share something" and not "share via email". specification must be in a scope such as "topbar_share".


## License
Open-source: AGPL-3.0 (see LICENSE)
Commercial: available on inquiry (see COMMERCIAL.md)