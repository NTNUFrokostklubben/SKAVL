import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings model used as the global state for settings
///
/// Stores settings persistent. Defaults to nb locale
class SettingsModel extends ChangeNotifier {
  static const _themeKey = 'settings.theme';
  static const _localeKey = 'settings.locale';

  ThemeMode _theme = ThemeMode.system;
  Locale? _locale;

  ThemeMode get theme => _theme;
  Locale? get locale => _locale;

  /// Load settings from shared preferences
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    final themeName = prefs.getString(_themeKey);
    _theme = ThemeMode.values.firstWhere(
          (m) => m.name == themeName,
      orElse: () => ThemeMode.system,
    );

    final localeCode = prefs.getString(_localeKey);
    _locale = switch (localeCode) {
      'en' => const Locale('en'),
      'nb' => const Locale('nb'),
      _ => null,
    };

    notifyListeners();
  }

  /// Set theme and save to shared preferences
  Future<void> setTheme(ThemeMode theme) async {
    _theme = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.name);
  }

  /// Set locale and save to shared preferences
  Future<void> setLocale(Locale? locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
  }
}
