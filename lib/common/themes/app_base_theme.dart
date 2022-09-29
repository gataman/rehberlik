import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_imports.dart';

abstract class AppBaseTheme {
  //! SETTINGS
  bool get applyElevationOverlayColor;
  Brightness get brightness;
  bool get useMaterial3;
  //! COLOR
  Color get backgroundColor;
  Color get canvasColor;
  Color get dividerColor;
  Color get primaryColor;
  Color get scaffoldBackgroundColor;

  ThemeData getThemeData();
  late final AppBaseTextTheme textBaseTheme;
  late final AppBaseAppBarTheme appBarBaseTheme;
}

abstract class AppBaseTextTheme {
  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleSmall;
  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;
  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;
  TextTheme get textTheme;
}

abstract class AppBaseAppBarTheme {
  Color get backgroundColor;
  double get elevation;

  AppBarTheme get appBarTheme;
}

abstract class AppBaseCardTheme {
  EdgeInsetsGeometry get margin;
  Color get surfaceTintColor;
  Color get color;
  ShapeBorder get shape;
}
