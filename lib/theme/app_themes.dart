import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';

/// Class to hold all app themes
///
/// [Text] inherits style from bodyMedium
/// [MenuAcceleratorLabel] inherits style from labelLarge
class AppThemes {

  /// Default light theme of the application.

  static final ThemeData lightTheme = ThemeData(
    colorScheme: .fromSeed(seedColor: Colors.green, primary: MyColors.primaryWhite, secondary: MyColors.secondaryBlack),
    textTheme: TextTheme(
      titleLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyMedium: const TextStyle(fontSize: 16),
      bodySmall: const TextStyle(fontSize: 12),
      labelLarge: const TextStyle(fontSize: 14)
    ),

    // PAGE TRANSITION THEME
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.windows: _NoTransitionsBuilder(),
        TargetPlatform.linux: _NoTransitionsBuilder(),
        TargetPlatform.macOS: _NoTransitionsBuilder(),
      },
    ),

    // INPUT DECORATION THEME
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: MyColors.darkGreen, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),  
      filled: true,
      fillColor: MyColors.primaryWhite,
      helperStyle: TextStyle(fontSize: 16, color: MyColors.secondaryBlack)
    ),

    // ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: MyColors.primaryWhite,
        foregroundColor: MyColors.secondaryBlack,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        overlayColor: MyColors.lightGreen,
      ),
    ),

    // TEXT BUTTON THEME
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MyColors.secondaryBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shadowColor: MyColors.grey,
      ),
    ),

    // SLIDER THEME
    sliderTheme: const SliderThemeData(
      thumbColor: MyColors.green,
      activeTrackColor: MyColors.darkGreen,
      inactiveTrackColor: MyColors.primaryWhite,
      overlayColor: MyColors.lightGreen,
    ),

    // PROGRESS INDICATOR THEME
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyColors.green,
    ),

    scaffoldBackgroundColor: MyColors.primaryWhite,

    // APP BAR THEME
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.primaryWhite,
      foregroundColor: MyColors.secondaryBlack,
      elevation: 0,
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
