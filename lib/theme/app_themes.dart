import 'package:flutter/material.dart';

/// Class to hold all app themes
///
/// [Text] inherits style from bodyMedium
/// [MenuAcceleratorLabel] inherits style from labelLarge
class AppThemes {

  /// Default light theme of the application.

  static final ThemeData lightTheme = ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    textTheme: TextTheme(
      titleLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyMedium: const TextStyle(fontSize: 16),
      bodySmall: const TextStyle(fontSize: 12),
      labelLarge: const TextStyle(fontSize: 14)
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.windows: _NoTransitionsBuilder(),
        TargetPlatform.linux: _NoTransitionsBuilder(),
      },
    ),
  );
}

/// Transition builder that disables page transitions for specified platforms
class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
