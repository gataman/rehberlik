import 'package:flutter/material.dart';
import '../constants.dart';

enum ThemeType { dark, light }

class CustomTheme {
  final ThemeType theme;

  CustomTheme({required this.theme});

  ThemeData getAppTheme() {
    switch (theme) {
      case ThemeType.dark:
        return darkTheme;
      case ThemeType.light:
        return lightTheme;
    }
  }

  final ThemeData darkTheme = ThemeData(
    applyElevationOverlayColor: false,
    brightness: Brightness.dark,
    useMaterial3: true,
    //! COLOR
    backgroundColor: Constants.darkBackgroundColor,
    canvasColor: Constants.darkCanvasColor,
    dividerColor: Constants.darkDividerColor,
    primaryColor: Constants.darkPrimaryColor,
    primaryColorDark: Constants.darkPrimaryColor,
    scaffoldBackgroundColor: Constants.darkBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Constants.darkPrimaryColor,
      onPrimary: Constants.darkOnPrimaryColor,
      secondary: Constants.darkSecondaryColor,
      error: Constants.darkErrorColor,
      onError: Constants.darkOnErrorColor,
      tertiary: Constants.darkTertiaryColor,
      onTertiary: Constants.darkOnTertiaryColor,
    ),

    //! // TYPOGRAPHY & ICONOGRAPHY

    textTheme: const TextTheme(
      //titleMedium: TextStyle(color: Colors.red),
      titleLarge: TextStyle(
        color: Constants.darkTitleColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Constants.darkTitleColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Constants.darkTitleColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: Constants.darkLabelColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      labelMedium: TextStyle(
        color: Constants.darkLabelColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),

      labelSmall: TextStyle(
        color: Constants.darkLabelColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),

      bodyLarge: TextStyle(
        fontSize: 14,
      ),

      bodyMedium: TextStyle(
        fontSize: 12,
      ),

      bodySmall: TextStyle(
        fontSize: 10,
      ),
    ),

    //! COMPONENT THEMES
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      surfaceTintColor: Constants.darkCanvasColor,
      color: Constants.darkCanvasColor,
      shape: Constants.getBorder(borderColor: Constants.darkDividerColor), //Border.all(color: Colors.white10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.darkPrimaryColor,
        //foregroundColor: ,
        foregroundColor: Constants.darkOnPrimaryColor,
        textStyle: const TextStyle(
          color: Constants.darkOnPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    dialogTheme: const DialogTheme(backgroundColor: Constants.darkBackgroundColor),
  );

//? LIGHT THEME

  final ThemeData lightTheme = ThemeData(
    applyElevationOverlayColor: false,
    brightness: Brightness.light,
    useMaterial3: true,

    //useMaterial3: true,
    //* COLOR
    backgroundColor: Constants.lightBackgroundColor,
    canvasColor: Constants.lightCanvasColor,
    dividerColor: Constants.lightDividerColor,
    primaryColor: Constants.lightPrimaryColor,
    scaffoldBackgroundColor: Constants.lightBackgroundColor,
    primaryColorDark: Constants.lightPrimaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Constants.lightPrimaryColor,
      onPrimary: Constants.lightOnPrimaryColor,
      secondary: Constants.lightSecondaryColor,
      error: Constants.lightErrorColor,
      onError: Constants.lightOnErrorColor,
      tertiary: Constants.lightTertiaryColor,
      onTertiary: Constants.lightOnTertiaryColor,
    ),

    //* // TYPOGRAPHY & ICONOGRAPHY

    textTheme: const TextTheme(
      //titleMedium: TextStyle(color: Colors.red),
      titleLarge: TextStyle(
        color: Constants.lightTitleColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Constants.lightTitleColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Constants.lightTitleColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),

      labelLarge: TextStyle(
        color: Constants.lightLabelColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),

      labelMedium: TextStyle(
        color: Constants.lightLabelColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),

      labelSmall: TextStyle(
        color: Constants.lightLabelColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),

      bodyLarge: TextStyle(
        fontSize: 14,
      ),

      bodyMedium: TextStyle(
        fontSize: 12,
      ),

      bodySmall: TextStyle(fontSize: 10, color: Colors.black),
    ),

    //* COMPONENT THEMES
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.darkBackgroundColor,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      surfaceTintColor: Constants.lightCanvasColor,
      color: Constants.lightCanvasColor,
      shape: Constants.getBorder(borderColor: Constants.lightDividerColor), //Border.all(color: Colors.white10),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Constants.darkBackgroundColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Constants.lightPrimaryColor,
          foregroundColor: Constants.lightOnPrimaryColor,
          textStyle: const TextStyle(color: Constants.lightOnPrimaryColor, fontWeight: FontWeight.bold)),
    ),
    dialogTheme: const DialogTheme(backgroundColor: Constants.lightBackgroundColor),
  );
}

/*

elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.lightPrimaryColor,
      ),
    ),

    */
