// Screen sizes:
import 'package:flutter/material.dart';

const primaryColor = Colors.teal;
const darkSecondaryColor = Color(0xFF2A2D3E);
const darkBackColor = Color(0xFF212332);

const lightSecondaryColor = Color(0xFFF3F3F3);
const lightBackColor = Color(0xFFD0D0D0);

const infoColor = Colors.teal;
const titleColor = Colors.amber;
const buttonColor = Colors.amber;
const warningColor = Colors.redAccent;
const defaultEditColor = Colors.lime;

const meetingStudentColor = Colors.lime;
const meetingParentColor = Colors.amber;
const meetingConferenceColor = Colors.lightBlue;
const meetingOthersColor = Colors.redAccent;

const defaultPadding = 16.0;
const minPadding = 8.0;
const defaultListHeight = 440.0;
const minimumBoxHeight = 250.0;
const mobileWidth = 600;
const tabletWidth = 850;
const desktopWidth = 1100;

const imagesSrc = "assets/images/";
const iconsSrc = "assets/icons/";

// ignore: constant_identifier_names
const TR_LOCALE = Locale('tr', 'TR');
// ignore: constant_identifier_names
const EN_LOCALE = Locale('en', 'EN');
// ignore: constant_identifier_names
const LANG_PATH = 'assets/translations';

const defaultInfoStyle = TextStyle(
  color: infoColor,
  fontSize: 14,
  fontStyle: FontStyle.italic,
);

const defaultDivider = Divider(
  thickness: .7,
  height: 0,
);

const defaultSubtitleStyle = TextStyle(
  color: infoColor,
  fontSize: 12,
);

const defaultDataTableTitleStyle = TextStyle(
  color: infoColor,
  fontSize: 12,
);

const defaultInfoTitle = TextStyle(
  color: infoColor,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const defaultDialogSubTitleStyle = TextStyle(
  color: infoColor,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const defaultDialogSubValueStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
);

const defaultTitleStyle = TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.bold);

const studentListSmallStyle = TextStyle(fontSize: 12);

var defaultBoxDecoration = BoxDecoration(
  color: darkSecondaryColor,
  border: Border.all(color: Colors.white10),
  borderRadius: const BorderRadius.all(
    Radius.circular(10),
  ),
);

var tableBoxDecoration = const BoxDecoration(
  color: darkSecondaryColor,
  border: Border(
      left: BorderSide(color: Colors.white10),
      top: BorderSide(color: Colors.white10),
      bottom: BorderSide(color: Colors.white10)),
);

const defaultDividerDecoration = BoxDecoration(
  color: darkSecondaryColor,
  border: Border(bottom: BorderSide(color: Colors.white10)),
);

class Constants {
  //! Size:
  static const double titleMediumFontSize = 16;

  //!Colors Dark:
  static const Color darkCanvasColor = Color(0xFF2A2D3E);
  static const Color darkBackgroundColor = Color(0xFF212332);
  static const Color darkDividerColor = Colors.white10;
  static const Color darkTitleColor = Colors.amber;
  static const Color darkLabelColor = Colors.teal;
  static const Color darkPrimaryColor = Colors.amber;
  static const Color darkOnPrimaryColor = Color(0xFF212332);
  static const Color darkSecondaryColor = Colors.teal;
  static const Color darkErrorColor = Colors.redAccent;
  static const Color darkOnErrorColor = Color(0xFF212332);
  static const Color darkTertiaryColor = Colors.lightGreen;
  static const Color darkOnTertiaryColor = Color(0xFF212332);

  //!Colors Light:
  static const Color lightCanvasColor = Colors.white;
  static const Color lightBackgroundColor = Color.fromARGB(255, 233, 232, 232);
  static const Color lightDividerColor = Colors.black12;
  static const Color lightTitleColor = Color.fromARGB(255, 33, 35, 50);
  static const Color lightLabelColor = Color.fromARGB(255, 130, 26, 0);
  static const Color lightPrimaryColor = lightTitleColor;
  static const Color lightOnPrimaryColor = Colors.white;
  static const Color lightSecondaryColor = Color.fromARGB(255, 130, 26, 0);
  static const Color lightErrorColor = Color.fromARGB(255, 130, 26, 0);
  static const Color lightOnErrorColor = Colors.white;
  static const Color lightTertiaryColor = Color.fromARGB(255, 46, 122, 49);
  static const Color lightOnTertiaryColor = Colors.white;

  //! Borders:
  static RoundedRectangleBorder getBorder({
    required Color borderColor,
    double radius = 10,
    double borderWidth = .7,
  }) =>
      RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(radius),
      );

  static const List<String> trialExamType = ['90 Soru', '75 Soru'];
}

const meetingTypeList = <String>[
  'Öğrenci Görüşmesi',
  'Veli Görüşmesi',
  'Toplantılar / Seminerler',
  'Diğer İş ve İşlemler',
];




//! Sonradan eklenenler:

