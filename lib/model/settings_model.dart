import 'package:flutter/cupertino.dart';

/// Settings model used as the global state for settings
/// TODO: Make this persistent in the future
class SettingsModel extends ChangeNotifier {
  Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) {
      return;
    }
    _locale = locale;
    notifyListeners();
  }
}