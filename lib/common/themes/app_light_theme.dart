import 'package:flutter/material.dart';
import 'package:rehberlik/common/themes/app_base_theme.dart';

import '../constants.dart';

class AppLightTheme implements AppBaseTheme {
  @override
  bool get applyElevationOverlayColor => false;

  @override
  Color get backgroundColor => Constants.lightBackgroundColor;

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get canvasColor => Constants.lightCanvasColor;

  @override
  Color get dividerColor => Constants.lightDividerColor;

  @override
  Color get primaryColor => Constants.lightPrimaryColor;

  @override
  Color get scaffoldBackgroundColor => Constants.lightBackgroundColor;

  @override
  bool get useMaterial3 => false;

  @override
  ThemeData getThemeData() => ThemeData(
      applyElevationOverlayColor: applyElevationOverlayColor,
      brightness: brightness,
      useMaterial3: useMaterial3,
      backgroundColor: backgroundColor,
      canvasColor: canvasColor,
      dividerColor: dividerColor,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: textBaseTheme.textTheme,
      appBarTheme: appBarBaseTheme.appBarTheme);

  @override
  AppBaseTextTheme textBaseTheme = _TextTheme();

  @override
  AppBaseAppBarTheme appBarBaseTheme = _AppBarTheme();
}

class _TextTheme implements AppBaseTextTheme {
  @override
  TextStyle get bodyLarge => const TextStyle(
        fontSize: 14,
      );

  @override
  TextStyle get bodyMedium => const TextStyle(
        fontSize: 12,
      );

  @override
  TextStyle get bodySmall => const TextStyle(
        fontSize: 10,
      );

  @override
  TextStyle get labelLarge => const TextStyle(
        color: Constants.lightLabelColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get labelMedium => const TextStyle(
        color: Constants.lightLabelColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get labelSmall => const TextStyle(
        color: Constants.lightLabelColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleLarge => const TextStyle(
        color: Constants.lightTitleColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleMedium => const TextStyle(
        color: Constants.lightTitleColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleSmall => const TextStyle(
        color: Constants.lightTitleColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      );

  @override
  TextTheme get textTheme => TextTheme(
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall);
}

class _AppBarTheme implements AppBaseAppBarTheme {
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: elevation,
      );

  @override
  Color get backgroundColor => Constants.darkBackgroundColor;

  @override
  double get elevation => 0;
}
