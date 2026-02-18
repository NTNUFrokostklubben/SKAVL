import 'package:flutter/material.dart';

/// Class to hold all app themes
class AppThemes {
  static final ThemeData lightTheme = ThemeData(
      colorScheme: .fromSeed(seedColor: Colors.deepPurple),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.windows: _NoTransitionsBuilder(),
        TargetPlatform.linux: _NoTransitionsBuilder(),
      }
    )
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