import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';

/// Class to hold all app themes
///
/// [Text] inherits style from bodyMedium
/// [MenuAcceleratorLabel] inherits style from labelLarge
class AppThemes {

  /// Default light theme of the application.

  static final ThemeData lightTheme = ThemeData(
    colorScheme: .fromSeed(seedColor: MyColors.lightGreen, primary: MyColors.primaryWhite, secondary: MyColors.secondaryBlack),
    textTheme: TextTheme(
      titleLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: MyColors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: MyColors.darkGreen, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),  
      filled: true,
      fillColor: MyColors.primaryWhite,
      helperStyle: TextStyle(fontSize: 16, color: MyColors.secondaryBlack),
      labelStyle: TextStyle(fontSize: 16, color: MyColors.secondaryBlack),
    ),

    // ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: MyColors.primaryWhite,
        foregroundColor: MyColors.secondaryBlack,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        overlayColor: MyColors.lightGreen,
        shadowColor: MyColors.grey,
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


  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyColors.darkGreen,
      primary: MyColors.secondaryBlack,
      secondary: MyColors.primaryWhite,
      brightness: Brightness.dark,
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: MyColors.primaryWhite,
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: MyColors.primaryWhite,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: MyColors.primaryWhite,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: MyColors.primaryWhite),
      bodySmall: TextStyle(fontSize: 12, color: MyColors.primaryWhite),
      labelLarge: TextStyle(fontSize: 14, color: MyColors.primaryWhite),
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: MyColors.lightGreen, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: MyColors.darkGreen, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      filled: true,
      fillColor: MyColors.darkGrey,
      helperStyle: TextStyle(fontSize: 16, color: MyColors.primaryWhite),
      labelStyle: TextStyle(fontSize: 16, color: MyColors.primaryWhite),
    ),

    // ELEVATED BUTTON THEME
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: MyColors.darkGrey,
        foregroundColor: MyColors.primaryWhite,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        overlayColor: MyColors.darkGreen,
        shadowColor: MyColors.darkGrey
      ),
    ),

    // TEXT BUTTON THEME
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        // backgroundColor: MyColors.darkGrey,
        foregroundColor: MyColors.primaryWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shadowColor: MyColors.grey,
      ),
    ),

    // SLIDER THEME
    sliderTheme: const SliderThemeData(
      thumbColor: MyColors.lightGreen,
      activeTrackColor: MyColors.green,
      inactiveTrackColor: MyColors.lightBlue,
      overlayColor: MyColors.darkGreen,
    ),

    // PROGRESS INDICATOR THEME
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: MyColors.lightGreen,
    ),

    scaffoldBackgroundColor: MyColors.secondaryBlack,

    // APP BAR THEME
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.secondaryBlack,
      foregroundColor: MyColors.primaryWhite,
      elevation: 0,
    ),

    bottomAppBarTheme: const BottomAppBarThemeData(
      color: MyColors.secondaryBlack,
      surfaceTintColor: MyColors.darkGreen,
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
