import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Settings model used as the global state for settings
/// TODO: Make this persistent in the future
class SettingsModel extends ChangeNotifier {
  ThemeMode _theme = ThemeMode.system;
  Locale _locale = const Locale('en');

  ThemeMode get theme => _theme;
  Locale get locale => _locale;

  void setTheme(ThemeMode theme) {
    _theme = theme;
    notifyListeners(); // important to rebuild MaterialApp
  }

  void setLocale(Locale? locale) {
    if (locale != null) {
      _locale = locale;
      notifyListeners();
    }
  }
}
