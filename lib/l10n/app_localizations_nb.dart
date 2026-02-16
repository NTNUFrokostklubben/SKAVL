// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get helloWorld => 'Hallo verden!';

  @override
  String get welcomeSKAVL => 'Velkommen til SKAVL!';

  @override
  String get openFormer => 'Åpne tidligere anomalianalyse';

  @override
  String get createNew => 'Opprett ny anomalianalyse';

  @override
  String get settings_title => 'Innstillinger';

  @override
  String get settings_language => 'Språk';

  @override
  String get g_enloc => 'Engelsk';

  @override
  String get g_nbloc => 'Norsk (Bokmål)';
}
