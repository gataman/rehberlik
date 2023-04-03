import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/constants.dart';

class MyThemes {
  static ThemeData darkThemes(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: darkBackColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      canvasColor: darkSecondaryColor,
    );
  }

  static ThemeData lightThemes(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: lightBackColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      canvasColor: lightSecondaryColor,
    );
  }
}
