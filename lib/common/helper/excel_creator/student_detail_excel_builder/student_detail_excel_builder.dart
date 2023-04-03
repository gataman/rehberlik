// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/helper.dart';
import 'package:rehberlik/common/helper/excel_creator/excel_box_settings.dart';
import 'package:rehberlik/common/helper/excel_creator/student_detail_excel_builder/student_detail_excel_helper.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/question_follow.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/models/trial_exam_student_result.dart';
import 'package:rehberlik/views/admin/admin_student_trial_exam_detail_view/cubit/student_trial_exam_detail_cubit.dart';

import '../../../../models/helpers/lesson_with_subject.dart';
import '../../../../models/subject.dart';
import '../../../../views/admin/admin_student_detail/components/student_detail_tab_view/question_follow/cubit/question_follow_list_cubit.dart';
import '../../../../views/admin/admin_student_detail/components/student_detail_tab_view/time_table/cubit/time_table_list_cubit.dart';

class StudentDetailExcelBuilder {
  final ValueNotifier<bool> notifier = ValueNotifier(false);
  final BuildContext context;

  StudentDetailExcelBuilder(this.context);

  Future<void> build(Student student) async {
    final timeTableListCubit = context.read<TimeTableListCubit>();
    final questionFollowListCubit = context.read<QuestionFollowListCubit>();
    final trialExamCubit = context.read<StudentTrialExamDetailCubit>();

    var timeTableList = timeTableListCubit.timeTableList;
    timeTableList ??= await timeTableListCubit.fetchTimeTableList(student: student);

    var questionFollowList = questionFollowListCubit.questionFollowList;
    questionFollowList ??= await questionFollowListCubit.fetchQuestionFollowList(studentID: student.id!);

    var trialExamStudentResult = trialExamCubit.trialExamStudentResult;
    if (trialExamStudentResult == null) {
      await trialExamCubit.getExamResult(student);
      trialExamStudentResult = trialExamCubit.trialExamStudentResult;
    }

    final Workbook workbook = Workbook(1);

    await _createPage1(workbook, student, questionFollowList, timeTableList, trialExamStudentResult);

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.

    //Save and launch the file.
    await FileSaveHelper.saveAndLaunchFile(bytes, '${student.studentNumber}.xlsx');
    notifier.value = false;
    workbook.dispose();
  }

// PAGE 1 -->
  Future<void> _createPage1(Workbook workbook, Student student, List<QuestionFollow>? questionFollowList,
      Map<int, List<TimeTable>>? timeTableList, TrialExamStudentResult? trialExamStudentResult) async {
    final Worksheet sheet = workbook.worksheets[0];
    int firstRow = 1;
    int firstColumn = 1;
    int lastColumn = firstColumn + 25;

    //Cell Settings:
    final headerSettings =
        ExcelBoxSettings(firstRow: firstRow, lastRow: firstRow + 3, firstColumn: firstColumn, lastColumn: lastColumn);

    // Student Info
    final studentInfoSettings = ExcelBoxSettings(
        firstRow: headerSettings.lastRow + 1,
        lastRow: headerSettings.lastRow + 3,
        firstColumn: firstColumn,
        lastColumn: lastColumn);

    // Question Follow
    final questionFollowSettings = ExcelBoxSettings(
        firstRow: studentInfoSettings.lastRow + 2,
        lastRow: studentInfoSettings.lastRow + 11,
        firstColumn: firstColumn,
        lastColumn: lastColumn);

    // Time Table
    final timeTableSettings = ExcelBoxSettings(
        firstRow: questionFollowSettings.lastRow + 2,
        lastRow: questionFollowSettings.lastRow + 14,
        firstColumn: firstColumn,
        lastColumn: lastColumn);

    // Footer
    final footerSettings = ExcelBoxSettings(
        firstRow: timeTableSettings.lastRow + 2,
        lastRow: timeTableSettings.lastRow + 16,
        firstColumn: firstColumn,
        lastColumn: lastColumn);

    _setWidth(sheet: sheet, firstColumn: firstColumn, lastColumn: lastColumn);

    //Header:
    final _Header headerBox = _Header(worksheet: sheet, box: headerSettings);
    headerBox.build();

    //Student Info:
    final _StudentInfoBox studentInfoBox =
        _StudentInfoBox(worksheet: sheet, student: student, box: studentInfoSettings);
    studentInfoBox.build();

    // Question Follow Box
    if (questionFollowList != null) {
      final _QuestionFollowBox questionFollowBox =
          _QuestionFollowBox(worksheet: sheet, questionFollowList: questionFollowList, box: questionFollowSettings);
      questionFollowBox.build();
    }

    // TimeTable Box
    final _TimeTableBox timeTableBox =
        _TimeTableBox(worksheet: sheet, timeTableList: timeTableList!, box: timeTableSettings, context: context);
    timeTableBox.build();

    final _FooterBox footerBox =
        _FooterBox(worksheet: sheet, trialExamStudentResult: trialExamStudentResult, box: footerSettings);
    footerBox.build();

    _pageSetup(sheet);
  }

  void _pageSetup(Worksheet sheet) {
    sheet.name = 'Çalışma Planı';
    var pageSetup = sheet.pageSetup;

    pageSetup.leftMargin = .25;
    pageSetup.rightMargin = .25;
    pageSetup.topMargin = .25;
    pageSetup.bottomMargin = .20;
    pageSetup.orientation = ExcelPageOrientation.landscape;
    pageSetup.printArea = 'A1:Z50';
  }

  void _setWidth({required Worksheet sheet, required int firstColumn, required int lastColumn}) {
    //Column Width
    sheet.getRangeByIndex(1, firstColumn + 2, 1, lastColumn).columnWidth = 8.17;
    sheet.getRangeByIndex(1, firstColumn).columnWidth = 20.84;
    sheet.getRangeByIndex(1, firstColumn + 1).columnWidth = 16.0;
  }
}

class _Header {
  final StudentDetailExcelHelper _helper = locator<StudentDetailExcelHelper>();
  final Worksheet worksheet;

  final ExcelBoxSettings box;

  _Header({required this.worksheet, required this.box});

  void build() {
    _setStyle();
    _setMerge();
    _setValue();
  }

  void _setStyle() {
    final weekStyle =
        worksheet.getRangeByIndex(box.firstRow, box.firstColumn, box.firstRow + 1, box.firstColumn + 1).cellStyle;
    _helper.setStyle(
        style: weekStyle, isBold: true, hAlign: HAlignType.left, fontSize: 38, fontName: 'Alegreya Sans SC Black');

    final weekWordLabelStyle =
        worksheet.getRangeByIndex(box.firstRow, box.lastColumn - 7, box.firstRow, box.lastColumn).cellStyle;
    _helper.setStyle(
        style: weekWordLabelStyle, hAlign: HAlignType.right, fontName: 'Alegreya Sans SC Black', fontSize: 10);

    final weekWordStyle =
        worksheet.getRangeByIndex(box.firstRow + 1, box.lastColumn - 7, box.firstRow + 1, box.lastColumn).cellStyle;
    _helper.setStyle(style: weekWordStyle, hAlign: HAlignType.right, fontSize: 10);

    final titleStyle =
        worksheet.getRangeByIndex(box.firstRow + 3, box.firstColumn, box.firstRow + 3, box.lastColumn).cellStyle;
    _helper.setStyle(style: titleStyle, fontSize: 36, isBold: true, fontName: 'Alegreya Sans SC Black');
    _helper.setColors(style: titleStyle);
  }

  void _setMerge() {
    // Hafta Label Merge
    worksheet.getRangeByIndex(box.firstRow, box.firstColumn, box.firstRow + 1, box.firstColumn + 1).merge();
    // Motivasyon Sözü Label Merge
    worksheet.getRangeByIndex(box.firstRow, box.lastColumn - 7, box.firstRow, box.lastColumn).merge();
    // Motivasyon Sözü Merge
    worksheet.getRangeByIndex(box.firstRow + 1, box.lastColumn - 7, box.firstRow + 1, box.lastColumn).merge();

    //Title merge
    worksheet.getRangeByIndex(box.firstRow + 3, box.firstColumn, box.firstRow + 3, box.lastColumn).merge();
  }

  void _setValue() {
    // Studetn Info
    worksheet.getRangeByIndex(box.firstRow, box.firstColumn).setText('11. HAFTA');
    worksheet.getRangeByIndex(box.firstRow, box.lastColumn - 7).setText('MOTİVASYON SÖZÜM');
    worksheet
        .getRangeByIndex(box.firstRow + 1, box.lastColumn - 7)
        .setText('BİLGİNİN EFENDİSİ OLMAK İÇİN ÇALIŞMANIN KÖLESİ OLMAK GEREKİR.');
    worksheet.getRangeByIndex(box.lastRow, box.firstColumn).setText('HAFTALIK ÇALIŞMA PROGRAMI');
  }
}

class _StudentInfoBox {
  final StudentDetailExcelHelper _helper = locator<StudentDetailExcelHelper>();
  final Worksheet worksheet;
  final Student student;
  final ExcelBoxSettings box;

  _StudentInfoBox({required this.worksheet, required this.student, required this.box});

  void build() {
    _setStyle();
    _setMerge();
    _setValue();
  }

  void _setStyle() {
    final titleStyle = worksheet.getRangeByIndex(box.firstRow, box.firstColumn, box.lastRow, box.firstColumn).cellStyle;
    _helper.setStyle(style: titleStyle, isBold: true, hAlign: HAlignType.left);

    final valueStyle =
        worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 1, box.lastRow, box.firstColumn + 1).cellStyle;
    _helper.setStyle(style: valueStyle, hAlign: HAlignType.left);

    final targetStyle =
        worksheet.getRangeByIndex(box.firstRow, box.lastColumn - 8, box.firstRow, box.lastColumn).cellStyle;
    _helper.setStyle(style: targetStyle, isBold: true);

    final pointStyle =
        worksheet.getRangeByIndex(box.lastRow, box.lastColumn - 8, box.lastRow, box.lastColumn).cellStyle;
    _helper.setStyle(style: pointStyle, fontSize: 11, isBold: true, hAlign: HAlignType.left);
  }

  void _setMerge() {
    // Öğrenci Bilgileri
    worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 1, box.firstRow, box.firstColumn + 4).merge();
    worksheet.getRangeByIndex(box.firstRow, box.lastColumn - 8, box.firstRow, box.lastColumn).merge();
    worksheet.getRangeByIndex(box.firstRow + 1, box.lastColumn - 8, box.firstRow + 1, box.lastColumn).merge();
    worksheet.getRangeByIndex(box.firstRow + 2, box.lastColumn - 8, box.firstRow + 2, box.lastColumn - 5).merge();
    worksheet.getRangeByIndex(box.firstRow + 2, box.lastColumn - 4, box.firstRow + 2, box.lastColumn).merge();
  }

  void _setValue() {
    // Studetn Info
    worksheet.getRangeByIndex(box.firstRow, box.firstColumn).setText('ADI SOYADI');
    worksheet.getRangeByIndex(box.firstRow + 1, box.firstColumn).setText('SINIFI');
    worksheet.getRangeByIndex(box.firstRow + 2, box.firstColumn).setText('OKUL NO');
    worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 1).setText(student.studentName);
    worksheet.getRangeByIndex(box.firstRow + 1, box.firstColumn + 1).setText(student.className);
    worksheet.getRangeByIndex(box.firstRow + 2, box.firstColumn + 1).setNumber(double.parse(student.studentNumber!));

    worksheet.getRangeByIndex(box.firstRow, box.lastColumn - 8).setText('HEDEFİM / Puanı');
    worksheet.getRangeByIndex(box.lastRow, box.lastColumn - 8).setText('Puanı:');
    worksheet.getRangeByIndex(box.lastRow, box.lastColumn - 4).setText('Yüzdelik Dilimi:');
  }
}

// _QuestionFollowBox
class _QuestionFollowBox {
  final StudentDetailExcelHelper _helper = locator<StudentDetailExcelHelper>();
  final Worksheet worksheet;
  final List<QuestionFollow> questionFollowList;
  final ExcelBoxSettings box;

  _QuestionFollowBox({required this.worksheet, required this.questionFollowList, required this.box});

  void build() {
    _setStyle();
    _setMerge();
    _addTitles();
    _addQuestionFollowsValue();
  }

  void _setStyle() {
    // First Row
    final firstRowStyle =
        worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 2, box.firstRow, box.lastColumn).cellStyle;
    _helper.setStyle(style: firstRowStyle, isBold: true, fontSize: 20);
    _helper.setBorderAll(style: firstRowStyle);

    //Second Row
    final secondRow1 =
        worksheet.getRangeByIndex(box.firstRow + 1, box.firstColumn, box.firstRow + 1, box.firstColumn + 1).cellStyle;
    _helper.setStyle(style: secondRow1, isBold: true, hAlign: HAlignType.left);
    _helper.setColors(style: secondRow1);
    _helper.setBorderAll(style: secondRow1);

    final secondRow2 =
        worksheet.getRangeByIndex(box.firstRow + 1, box.firstColumn + 2, box.firstRow + 1, box.lastColumn).cellStyle;
    _helper.setStyle(style: secondRow2, fontSize: 11);
    _helper.setColors(style: secondRow2);

    //Values:
    final values1 =
        worksheet.getRangeByIndex(box.firstRow + 2, box.firstColumn, box.lastRow - 1, box.firstColumn + 1).cellStyle;
    _helper.setStyle(style: values1, hAlign: HAlignType.left);

    final values2 =
        worksheet.getRangeByIndex(box.firstRow + 2, box.firstColumn + 2, box.lastRow, box.lastColumn).cellStyle;
    _helper.setStyle(style: values2, isBold: true);

    //Footer
    final footer1 = worksheet.getRangeByIndex(box.lastRow, box.firstColumn + 1, box.lastRow, box.lastColumn).cellStyle;
    _helper.setStyle(style: footer1, isBold: true);
    _helper.setBorderAll(style: footer1);

    //All
    final allBox =
        worksheet.getRangeByIndex(box.firstRow + 1, box.firstColumn, box.lastRow - 1, box.lastColumn).cellStyle;
    _helper.setBorderAll(style: allBox);
  }

  void _setMerge() {
    for (var i = 2; i < box.lastColumn; i = i + 4) {
      var column = box.firstColumn + i;
      worksheet.getRangeByIndex(box.firstRow, column, box.firstRow, column + 3).merge();
    }
  }

  void _addQuestionFollowsValue() {
    var columnCount = 26;
    var row = box.firstRow + 2;
    for (var questionFollow in questionFollowList) {
      for (var i = 1; i <= columnCount; i++) {
        var column = (box.firstColumn - 1) + i;
        if (i > 2) {
          final numberVal = _helper.getQuestionFollowNumber(column: i, questionFollow: questionFollow);
          worksheet.getRangeByIndex(row, column).setNumber(numberVal?.toDouble());
        } else {
          worksheet
              .getRangeByIndex(row, column)
              .setText(_helper.getQuestionFollowText(column: i, questionFollow: questionFollow));
        }

        //set cell value
        //_getQuestionFollowValues(row: row, column: i, questionFollow: questionFollow, sheet: sheet);
      }
      row++;
    }

    // Total Follow:
    final questionFollowMap = _helper.getQuestionFollowTotalCount(questionFollowList);
    questionFollowMap.forEach((index, value) {
      var column = (box.firstColumn + 2) + index;
      if (value != 0) {
        worksheet.getRangeByIndex(box.lastRow, column).setNumber(value.toDouble());
      }
    });
  }

  void _addTitles() {
    final lessonList = ['TÜRKÇE', 'MATEMATİK', 'FEN BİLİMLERİ', 'İNKILAP TARİHİ', 'İNGİLİZCE', 'DİN KÜLTÜRÜ'];
    var column = box.firstColumn + 2;
    for (var lesson in lessonList) {
      worksheet.getRangeByIndex(box.firstRow, column).setText(lesson);
      column = column + 4;
    }

    final titleList = ['HEDEF', 'ÇÖZÜLEN', 'DOĞRU', 'YANLIŞ'];
    int textIndex = 0;
    for (var i = 0; i < 24; i++) {
      if (textIndex > 3) {
        textIndex = 0;
      }
      var column = (box.firstColumn + 2) + i;
      worksheet.getRangeByIndex(box.firstRow + 1, column).setText(titleList[textIndex]);
      textIndex++;
    }

    worksheet.getRangeByIndex(box.lastRow, box.firstColumn + 1).setText('TOPLAM');
  }
}

class _TimeTableBox {
  final StudentDetailExcelHelper _helper = locator<StudentDetailExcelHelper>();
  final Worksheet worksheet;
  final Map<int, List<TimeTable>> timeTableList;
  final ExcelBoxSettings box;
  final BuildContext context;

  _TimeTableBox({required this.worksheet, required this.timeTableList, required this.box, required this.context});

  void build() {
    _setStyle();
    _setMergeAndValue();
    _setTimeTable();
  }

  void _setMergeAndValue() {
    final columnList = [0, 2, 6, 10, 14, 18, 22];
    final days = ['PAZARTESİ', 'SALI', 'ÇARŞAMBA', 'PERŞEMBE', 'CUMA', 'CUMARTESİ', 'PAZAR'];

    for (var i = 0; i < 13; i++) {
      var row = box.firstRow + i;
      worksheet.getRangeByIndex(row, 1, row, 1).rowHeight = 24.0;
      var dayIndex = 0;
      for (var col in columnList) {
        var column = box.firstColumn + col;
        var endColumn = column + 3;

        if (col == 0) {
          endColumn = column + 1;

          worksheet.getRangeByIndex(row, column, row, endColumn).cellStyle.borders.left.lineStyle =
              LineStyle.thin; //Sol çizgi
        }

        if (i == 0) {
          // Günler
          worksheet.getRangeByIndex(row, column, row, endColumn).setText(days[dayIndex]);

          //worksheet.getRangeByIndex(row, column, row, endColumn).cellStyle.borders.left.lineStyle = LineStyle.thin;
        }

        worksheet.getRangeByIndex(row, column, row, endColumn).merge();
        worksheet.getRangeByIndex(row, column, row, endColumn).cellStyle.borders.right.lineStyle =
            LineStyle.thin; // Sağ çizgi

        dayIndex++;
      }
    }

    for (var i = box.firstRow + 3; i <= box.lastRow; i = i + 3) {
      for (var col in columnList) {
        var column = box.firstColumn + col;
        var endColumn = column + 3;
        if (col == 0) {
          endColumn = column + 1;
        }
        worksheet.getRangeByIndex(i, column, i, endColumn).cellStyle.borders.bottom.lineStyle = LineStyle.thin;
      }
    }
  }

  void _setStyle() {
    final cellStyle = worksheet.getRangeByIndex(box.firstRow, box.firstColumn, box.firstRow, box.lastColumn).cellStyle;
    _helper.setStyle(style: cellStyle, isBold: true);
    _helper.setBorderAll(style: cellStyle);
    _helper.setColors(style: cellStyle);
  }

  void _setTimeTable() {
    timeTableList.forEach((index, list) {
      _setTimeTableValue((box.firstRow + 1 + (index * 3)), list);
    });
  }

  void _setTimeTableValue(int row, List<TimeTable> list) {
    final columnList = [0, 2, 6, 10, 14, 18, 22];
    for (var timeTable in list) {
      final index = timeTable.day - 1;
      var column = columnList[index] + box.firstColumn;
      //Saat
      worksheet.getRangeByIndex(row, column).setText(_getTimeTableDay(timeTable.startTime, timeTable.endTime));
      final timeStyle = worksheet.getRangeByIndex(row, column).cellStyle;
      _helper.setStyle(style: timeStyle, fontSize: 14);

      worksheet.getRangeByIndex(row + 1, column).setText(_getLessonNameText(lessonID: timeTable.lessonID));
      final lessonStyle = worksheet.getRangeByIndex(row + 1, column).cellStyle;
      _helper.setStyle(style: lessonStyle, isBold: true);

      worksheet
          .getRangeByIndex(row + 2, column)
          .setText(_getSubjectName(lessonID: timeTable.lessonID, subjectID: timeTable.subjectID));
      final subjectStyle = worksheet.getRangeByIndex(row + 2, column).cellStyle;
      _helper.setStyle(style: subjectStyle, fontSize: 14);
    }
  }

  String _getTimeTableDay(int? startTime, int? endTime) {
    if (startTime != null && endTime != null) {
      return "${Helper.getTimeDayText(startTime)} - ${Helper.getTimeDayText(endTime)}";
    } else {
      return "";
    }
  }

  String _getLessonNameText({String? lessonID}) {
    final timeTableListCubit = context.read<TimeTableListCubit>();
    final lessonList = timeTableListCubit.lessonWithSubjectList;
    if (lessonList != null && lessonList.isNotEmpty) {
      if (lessonID != null) {
        LessonWithSubject? lessonWithSubject = lessonList.findOrNull((element) => element.lesson.id == lessonID);
        if (lessonWithSubject != null) {
          return lessonWithSubject.lesson.lessonName!;
        }
      }
    }

    return "";
  }

  String _getSubjectName({required String? lessonID, required String? subjectID}) {
    final timeTableListCubit = context.read<TimeTableListCubit>();
    final lessonList = timeTableListCubit.lessonWithSubjectList;
    if (lessonList != null && lessonList.isNotEmpty) {
      if (lessonID != null) {
        LessonWithSubject? lessonWithSubject = lessonList.findOrNull((element) => element.lesson.id == lessonID);
        if (lessonWithSubject != null) {
          if (lessonWithSubject.subjectList != null) {
            Subject? subject = lessonWithSubject.subjectList!.findOrNull((subject) => subject.id == subjectID);
            if (subject != null) {
              return subject.subject!;
            }
          }
        }
      }
    }
    return "";
  }
}

class _FooterBox {
  final StudentDetailExcelHelper _helper = locator<StudentDetailExcelHelper>();
  final TrialExamStudentResult? trialExamStudentResult;
  final ExcelBoxSettings box;
  final Worksheet worksheet;

  _FooterBox({required this.trialExamStudentResult, required this.box, required this.worksheet});

  void build() {
    _setMerge();
    _setStaticValues();
    _setStyle();
  }

  void _setMerge() {
    //Notlar Title
    final notesTitleCell = worksheet.getRangeByIndex(box.firstRow, box.firstColumn, box.firstRow + 1, box.firstColumn);
    notesTitleCell.merge();
    _helper.setStyle(style: notesTitleCell.cellStyle, isBold: true);
    _helper.setBorderAll(style: notesTitleCell.cellStyle);
    notesTitleCell.setText('NOTLAR');

    for (var i = 0; i < 10; i++) {
      if (i < 2) {
        //First Two Notes Row
        worksheet
            .getRangeByIndex(box.firstRow + i, box.firstColumn + 1, box.firstRow + i, box.firstColumn + 13)
            .merge();
      } else {
        //First Two Notes Row
        worksheet.getRangeByIndex(box.firstRow + i, box.firstColumn, box.firstRow + i, box.firstColumn + 13).merge();
      }
    }

    for (var i = 2; i <= 8; i = i + 2) {
      for (var col = box.firstColumn + 14; col <= box.lastColumn; col = col + 2) {
        if (i != 6) {
          worksheet.getRangeByIndex(box.firstRow + i, col, (box.firstRow + i) + 1, col + 1).merge();
        }
      }
    }

    // Deneme Ortalamaları:

    worksheet
        .getRangeByIndex(box.firstRow + 6, box.firstColumn + 14, box.firstRow + 7, box.lastColumn)
        .merge(); // Alt başlık

    final lessonList = ['TÜRKÇE', 'MATEMATİK', 'FEN BİLİMLERİ', 'İNKILAP TARİHİ', 'İNGİLİZCE', 'DİN KÜLTÜRÜ'];
    var col = box.firstColumn + 14;

    for (var i = 0; i < lessonList.length; i++) {
      final cell = worksheet.getRangeByIndex(box.firstRow + 2, col, box.firstRow + 3, col + 1);
      cell.setText(lessonList[i]);
      col = col + 2;
    }

    var examResultIndex = 0;
    for (var col = box.firstColumn + 14; col <= box.lastColumn; col = col + 2) {
      //final lessonStyle = worksheet.getRangeByIndex(box.firstRow, col, box.firstRow + 1, col + 1);

      final cell = worksheet.getRangeByIndex(box.firstRow + 4, col, box.firstRow + 5, col + 1);
      cell.merge();
      if (trialExamStudentResult != null) {
        cell.setNumber(_getExamResult(index: examResultIndex, examResult: trialExamStudentResult!));
      }
      examResultIndex++;
    }
  }

  void _setStaticValues() {
    worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 14).setText('DENEME ORTALAMALARIM');
    // Rehber Öğretmen
    final teacherNameCell = worksheet.getRangeByIndex(box.lastRow - 1, box.firstColumn);
    final teacherPosCell = worksheet.getRangeByIndex(box.lastRow, box.firstColumn);

    final schoolNameCell = worksheet.getRangeByIndex(box.lastRow - 1, box.lastColumn);
    final schoolUnitCell = worksheet.getRangeByIndex(box.lastRow, box.lastColumn);

    _helper.setStyle(style: teacherNameCell.cellStyle, isBold: true, fontSize: 11, hAlign: HAlignType.left);
    _helper.setStyle(style: teacherPosCell.cellStyle, fontSize: 11, hAlign: HAlignType.left);
    _helper.setStyle(style: schoolNameCell.cellStyle, isBold: true, fontSize: 11, hAlign: HAlignType.right);
    _helper.setStyle(style: schoolUnitCell.cellStyle, fontSize: 11, hAlign: HAlignType.right);

    teacherNameCell.setText('Ufuk ŞAD');
    teacherPosCell.setText('Psikolojik Danışman');
    schoolNameCell.setText('YAVUZ SELİM ORTAOKULU');
    schoolUnitCell.setText('PSİKOLOJİK DANIŞMA VE REHBERLİK BİRİMİ');
  }

  void _setStyle() {
    //Notlar box dashed
    worksheet
        .getRangeByIndex(box.firstRow, box.firstColumn, box.lastRow - 5, box.firstColumn + 13)
        .cellStyle
        .borders
        .all
        .lineStyle = LineStyle.dashed;

    final averageTitleCell =
        worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 14, box.firstRow + 1, box.lastColumn);
    averageTitleCell.merge();
    _helper.setColors(style: averageTitleCell.cellStyle);
    _helper.setStyle(style: averageTitleCell.cellStyle, isBold: true);

    final averageSubTitle =
        worksheet.getRangeByIndex(box.firstRow + 6, box.firstColumn + 14, box.firstRow + 7, box.lastColumn);
    averageSubTitle.setText('HEDEFLEDİĞİM OKULA GİTMEK İÇİN YAPMAM GEREKEN NETLER');

    _helper.setBorderAll(style: averageSubTitle.cellStyle);
    _helper.setColors(style: averageSubTitle.cellStyle);
    _helper.setStyle(style: averageSubTitle.cellStyle, isBold: true);

    final averageBoxStyle =
        worksheet.getRangeByIndex(box.firstRow, box.firstColumn + 14, box.lastRow - 5, box.lastColumn).cellStyle;
    _helper.setBorderAll(style: averageBoxStyle);

    final averageLessonsStyle =
        worksheet.getRangeByIndex(box.firstRow + 2, box.firstColumn + 14, box.firstRow + 3, box.lastColumn).cellStyle;
    _helper.setStyle(style: averageLessonsStyle, isBold: true, fontSize: 11);

    final averageStyle =
        worksheet.getRangeByIndex(box.firstRow + 4, box.firstColumn + 14, box.firstRow + 5, box.lastColumn).cellStyle;
    _helper.setStyle(style: averageStyle, fontSize: 14);
  }

  double _getExamResult({required int index, required TrialExamStudentResult examResult}) {
    switch (index) {
      case 0:
        return examResult.turNetAvg;
      case 1:
        return examResult.matNetAvg;
      case 2:
        return examResult.fenNetAvg;
      case 3:
        return examResult.sosNetAvg;
      case 4:
        return examResult.ingNetAvg;
      case 5:
        return examResult.dinNetAvg;
      default:
        return 0;
    }
  }
}
