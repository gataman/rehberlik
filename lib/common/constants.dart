// Screen sizes:
import 'package:flutter/material.dart';

const primaryColor = Colors.teal;
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

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
const mobileWidth = 600;
const tabletWidth = 850;
const desktopWidth = 1100;

const imagesSrc = "assets/images/";
const iconsSrc = "assets/icons/";

const defaultInfoStyle = TextStyle(
  color: infoColor,
  fontSize: 14,
  fontStyle: FontStyle.italic,
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

const defaultTitleStyle =
    TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.bold);

const studentListSmallStyle = TextStyle(fontSize: 12);

var defaultBoxDecoration = BoxDecoration(
  color: secondaryColor,
  border: Border.all(color: Colors.white10),
  borderRadius: const BorderRadius.all(
    Radius.circular(10),
  ),
);

const defaultDividerDecoration = BoxDecoration(
  color: secondaryColor,
  border: Border(bottom: BorderSide(color: Colors.white10)),
);

class Constants {
  static const String routeDashboard = "/admin_dashboard";
  static const String routeClasses = "/admin_classes";
  static const String routeStudents = "/admin_students";
  static const String routeStudentDetail = "/admin_student_detail";
  static const String routeLessons = "/admin_lessons";
  static const String routeStudyProgram = "/admin_study_program";
  static const String routeSubjects = "/admin_subject";
  static const String routeMessages = "/admin_messages";
  static const String routeUploads = "/admin_uploads";
  static const String routeTrialExams = "/admin_trial_exams";
  static const String routeTrialExamResult = "/admin_trial_exam_result";
  static const String routeTrialExamExcelImport =
      "/admin_trial_exam_result_exam_import";
}

const meetingTypeList = <String>[
  'Öğrenci Görüşmesi',
  'Veli Görüşmesi',
  'Toplantılar / Seminerler',
  'Diğer İş ve İşlemler',
];
