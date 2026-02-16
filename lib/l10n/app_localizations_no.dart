// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get helloWorld => 'Hallo verden!';

  @override
  String get welcomeSKAVL => 'Velkommen til SKAVL!';

  @override
  String get openFormer => 'Åpne tidligere anomalianalyse';

  @override
  String get createNew => 'Opprett ny anomalianalyse';
}
