import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/helper/excel_creator/student_detail_excel_builder/student_detail_excel_helper.dart';
import 'package:rehberlik/models/question_follow.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../views/admin/admin_student_detail/components/student_detail_tab_view/question_follow/cubit/question_follow_list_cubit.dart';
import '../../../../views/admin/admin_student_detail/components/student_detail_tab_view/time_table/cubit/time_table_list_cubit.dart';
import '../../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';

class StudentDetailExcelBuilder {
  final ValueNotifier<bool> notifier = ValueNotifier(false);
  final BuildContext context;
  late StudentDetailExcelHelper _helper;

  StudentDetailExcelBuilder(this.context) {
    _helper = StudentDetailExcelHelper();
  }

  Future<void> build(Student student) async {
    final timeTableListCubit = context.read<TimeTableListCubit>();
    final questionFollowListCubit = context.read<QuestionFollowListCubit>();
    var timeTableList = timeTableListCubit.timeTableList;
    timeTableList ??= await timeTableListCubit.fetchTimeTableList(student: student);

    var questionFollowList = questionFollowListCubit.questionFollowList;
    questionFollowList ??= await questionFollowListCubit.fetchQuestionFollowList(studentID: student.id!);

    final Workbook workbook = Workbook(1);

    await _createPage1(workbook, student, questionFollowList, timeTableList);

    //sheet2.name = 'Veriler';
    //sheet2.visibility = WorksheetVisibility.hidden;

    //sheet.showGridlines = false;
    //sheet.enableSheetCalculations();

    // Charts:
    //final ChartCollection charts = ChartCollection(sheet);

    //Set width
    //sheet.getRangeByName('A1:D1').columnWidth = 4;
    //sheet.getRangeByName('E1').columnWidth = 8.5;
    // sheet.getRangeByName('A1:Y1').columnWidth = 4.67;

    // //Set height
    // sheet.getRangeByName('A1').rowHeight = 20;
    // sheet.getRangeByName('A2').rowHeight = 14.25;
    // sheet.getRangeByName('A3:A7').rowHeight = 30;
    // //sheet.getRangeByName('A8:A9').showRows(false);

    // //Merge
    // sheet.getRangeByName('B1:Y1').merge();
    // sheet.getRangeByName('B2:Y2').merge();

    // sheet.getRangeByName('B3:D3').merge();
    // sheet.getRangeByName('B4:D4').merge();
    // sheet.getRangeByName('B5:D5').merge();
    // sheet.getRangeByName('B6:D6').merge();
    // sheet.getRangeByName('B7:D7').merge();

    // sheet.getRangeByName('B8:Y9').merge();

    // sheet.getRangeByName('F3:M3').merge();
    // sheet.getRangeByName('F4:M4').merge();
    // sheet.getRangeByName('F5:M5').merge();
    // sheet.getRangeByName('F6:M6').merge();
    // sheet.getRangeByName('F7:M7').merge();
    // sheet.getRangeByName('N3:Y7').merge();

    //Style
    //_setStyles(workbook, sheet); // Ortalama Ders Başlık Style

    // //Titles
    // _setTitles(sheet);

    // // StudentInfo
    // _setStudentInfo(sheet, student!);

    // // Set Total Net
    // _setTotalNetGraph(sheet, sheet2, totalNetGraph, charts);

    // //Averages
    // _setAverages(sheet, trialExamStudentResult!, classAverages!, schoolAverages!);

    // // Charts
    // _setLessonCharts(sheet, sheet2, studentTrialExamGraphList, charts);
    // sheet.charts = charts;

    // _setExamResults(sheet, studentTrialExamResultList, workbook);

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.

    //Save and launch the file.
    await FileSaveHelper.saveAndLaunchFile(bytes, '${student.studentNumber}.xlsx');
    notifier.value = false;
    workbook.dispose();
  }

// PAGE 1 -->
  Future<void> _createPage1(Workbook workbook, Student student, List<QuestionFollow>? questionFollowList,
      Map<int, List<TimeTable>>? timeTableList) async {
    final Worksheet sheet = workbook.worksheets[0];
    _pageSetup(sheet);
    _mergeCells(sheet);
    _setStyle(workbook, sheet);
    _setDimensions(sheet);
    _setStaticValues(sheet);
    _setStudentInfo(sheet, student);
    await _setQuestionFollowTable(sheet, questionFollowList);
    _setTimeTable(timeTableList, sheet);
  }

  void _pageSetup(Worksheet sheet) {
    sheet.name = 'Öğrenci Karnesi';
    var pageSetup = sheet.pageSetup;

    pageSetup.leftMargin = .25;
    pageSetup.rightMargin = .25;
    pageSetup.topMargin = .25;
    pageSetup.bottomMargin = .20;
    pageSetup.orientation = ExcelPageOrientation.landscape;
    pageSetup.printArea = 'A1:Z40';
  }

  void _mergeCells(Worksheet sheet) {
    // Tam Satır
    sheet.getRangeByName('A1:Z1').merge();
    sheet.getRangeByName('A16:Z16').merge();

    // Öğrenci Bilgileri
    sheet.getRangeByName('B2:E2').merge();
    sheet.getRangeByName('R2:Z2').merge();
    sheet.getRangeByName('R3:Z3').merge();
    sheet.getRangeByName('R4:U4').merge();
    sheet.getRangeByName('V4:Z4').merge();

    //Soru Takip: (Dersler)
    sheet.getRangeByName('C6:F6').merge();
    sheet.getRangeByName('G6:J6').merge();
    sheet.getRangeByName('K6:N6').merge();
    sheet.getRangeByName('O6:R6').merge();
    sheet.getRangeByName('S6:V6').merge();
    sheet.getRangeByName('W6:Z6').merge();

    //Çalışma Takip (Günler)
    sheet.getRangeByName('A17:B17').merge();
    sheet.getRangeByName('C17:F17').merge();
    sheet.getRangeByName('G17:J17').merge();
    sheet.getRangeByName('K17:N17').merge();
    sheet.getRangeByName('O17:R17').merge();
    sheet.getRangeByName('S17:V17').merge();
    sheet.getRangeByName('W17:Z17').merge();

    //Çalışma Takip (Dersler)
    for (var i = 18; i < 30; i++) {
      sheet.getRangeByName('A$i:B$i').merge();
      sheet.getRangeByName('C$i:F$i').merge();
      sheet.getRangeByName('G$i:J$i').merge();
      sheet.getRangeByName('K$i:N$i').merge();
      sheet.getRangeByName('O$i:R$i').merge();
      sheet.getRangeByName('S$i:V$i').merge();
      sheet.getRangeByName('W$i:Z$i').merge();

      sheet.getRangeByName('A$i').rowHeight = 24;
    }

    //NOTES:
    for (var i = 31; i < 41; i++) {
      sheet.getRangeByName('A$i:N$i').merge();
    }

    //DENEME ORTALAMALARIM:
    sheet.getRangeByName('O31:Z32').merge();
    sheet.getRangeByName('O37:Z38').merge();

    for (var row = 33; row < 37; row = row + 2) {
      for (var column = 15; column < 27; column = column + 2) {
        sheet.getRangeByIndex(row, column, row + 1, column + 1).merge();
      }
    }

    for (var column = 15; column < 27; column = column + 2) {
      sheet.getRangeByIndex(39, column, 40, column + 1).merge();
    }
  }

  void _setStyle(Workbook workbook, Worksheet sheet) {
    final Style pageTitleStyle = _helper.pageTitleStyle(workbook);
    final Style subTitleStyle = _helper.subTitleStyle(workbook);
    final Style valueStyle18 = _helper.valueStyle18(workbook);
    final Style lessonTitleStyle = _helper.lessonTitleStyle(workbook);
    final Style lessonSubTitleStyle = _helper.lessonSubTitleStyle(workbook);

    sheet.getRangeByName('A1:Z1').cellStyle = pageTitleStyle;

    sheet.getRangeByName('A2:A4').cellStyle = subTitleStyle;
    sheet.getRangeByName('R2').cellStyle = subTitleStyle;
    sheet.getRangeByName('R2').cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('B2:B4').cellStyle = valueStyle18;
    sheet.getRangeByName('R3').cellStyle = valueStyle18;

    //Lessons:
    sheet.getRangeByName('C6:Z6').cellStyle = lessonTitleStyle;

    sheet.getRangeByName('A7:B7').cellStyle = subTitleStyle;
    sheet.getRangeByName('A7:B7').cellStyle.backColor = '#EFEFEF';

    sheet.getRangeByName('C7:Z7').cellStyle = lessonSubTitleStyle;

    sheet.getRangeByName('A8:Z15').cellStyle = valueStyle18;
    sheet.getRangeByName('C8:Z15').cellStyle.bold = true;
    sheet.getRangeByName('C8:Z15').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('B15').cellStyle.bold = true;

    // Time Table:
    sheet.getRangeByName('A17:Z17').cellStyle = lessonTitleStyle;
    sheet.getRangeByName('A17:Z17').cellStyle.backColor = '#EFEFEF';

    const startRow = 18;
    const endRow = 29;
    //Time Table Lesson:
    sheet.getRangeByName('A$startRow:B$endRow').cellStyle.borders.left.lineStyle = LineStyle.thin;
    sheet.getRangeByName('A$startRow:B$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;
    sheet.getRangeByName('C$startRow:F$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;
    sheet.getRangeByName('G$startRow:J$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;
    sheet.getRangeByName('K$startRow:N$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;
    sheet.getRangeByName('O$startRow:R$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;
    sheet.getRangeByName('S$startRow:V$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;
    sheet.getRangeByName('W$startRow:Z$endRow').cellStyle.borders.right.lineStyle = LineStyle.thin;

    for (var i = 20; i < 30; i = i + 3) {
      for (var j = 1; j < 8; j++) {
        sheet.getRangeByName(_helper.getTimeTableCell(day: j, row: i)).cellStyle.borders.bottom.lineStyle =
            LineStyle.thin;
      }
    }

    // for (var i = 18; i < 30; i + 3) {
    //   sheet.getRangeByName('A$i:B${i + 2}').cellStyle.borders.all.lineStyle = LineStyle.thin;
    // }

    //Manuel Style
    sheet.getRangeByName('A7:Z14').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet.getRangeByName('B15:Z15').cellStyle.borders.all.lineStyle = LineStyle.thin;
  }

  void _setDimensions(Worksheet sheet) {
    //Column Width
    sheet.getRangeByName('C7:Z7').columnWidth = 8.17;
    sheet.getRangeByName('A1').columnWidth = 20.84;
    sheet.getRangeByName('B1').columnWidth = 16.0;
    sheet.getRangeByName('A1').rowHeight = 41.25;

    sheet.getRangeByName('A2').rowHeight = 28.5;
  }

  void _setStaticValues(Worksheet sheet) {
    sheet.getRangeByName('A1:Z1').setText('HAFTALIK ÇALIŞMA PROGRAMI');

    sheet.getRangeByName('A2').setText('ADI SOYADI');
    sheet.getRangeByName('A3').setText('SINIFI');
    sheet.getRangeByName('A4').setText('OKUL NO');

    sheet.getRangeByName('R2').setText('HEDEFİM/Puanı');
    //sheet.getRangeByName('R2').setText('HEDEFİM/Puanı');

    //Lessons
    sheet.getRangeByName('C6').setText('TÜRKÇE');
    sheet.getRangeByName('G6').setText('MATEMATİK');
    sheet.getRangeByName('K6').setText('FEN BİLİMLERİ');
    sheet.getRangeByName('O6').setText('İNKILAP TARİHİ');
    sheet.getRangeByName('S6').setText('İNGİLİZCE');
    sheet.getRangeByName('W6').setText('DİN KÜLTÜRÜ');

    sheet.getRangeByName('A7').setText('TARİH');
    sheet.getRangeByName('B7').setText('GÜN');

    final titleList = ['HEDEF', 'ÇÖZÜLEN', 'DOĞRU', 'YANLIŞ'];
    int textIndex = 0;
    for (var i = 0; i < 24; i++) {
      if (textIndex > 3) {
        textIndex = 0;
      }
      sheet.getRangeByIndex(7, i + 3).setText(titleList[textIndex]);
      textIndex++;
    }

    sheet.getRangeByName('B15').setText('TOPLAM');

    //Time Table:
    sheet.getRangeByName('A17').setText('PAZARTESİ');
    sheet.getRangeByName('C17').setText('SALI');
    sheet.getRangeByName('G17').setText('ÇARŞAMBA');
    sheet.getRangeByName('K17').setText('PERŞEMBE');
    sheet.getRangeByName('O17').setText('CUMA');
    sheet.getRangeByName('S17').setText('CUMARTESİ');
    sheet.getRangeByName('W17').setText('PAZAR');

    //
  }

  void _setStudentInfo(Worksheet sheet, Student student) {
    sheet.getRangeByName('B2').setText(student.studentName);
    sheet.getRangeByName('B3').setText(student.className);
    sheet.getRangeByName('B4').setText(student.studentNumber);
  }

  Future<void> _setQuestionFollowTable(Worksheet sheet, List<QuestionFollow>? questionFollowList) async {
    var columnCount = 27;
    if (questionFollowList != null) {
      var row = 8;
      for (var questionFollow in questionFollowList) {
        for (var i = 1; i < columnCount; i++) {
          if (i > 2) {
            final numberVal = _helper.getQuestionFollowNumber(column: i, questionFollow: questionFollow);
            sheet.getRangeByIndex(row, i).setNumber(numberVal?.toDouble());
          } else {
            sheet
                .getRangeByIndex(row, i)
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
        if (value != 0) {
          sheet.getRangeByIndex(15, index + 3).setNumber(value.toDouble());
        }
      });
    }
  }

  void _setTimeTable(Map<int, List<TimeTable>>? timeTableList, Worksheet sheet) {
    if (timeTableList != null) {
      const startRow = 18;
      timeTableList.forEach((index, value) {
        _setTimeTableValue(startRow + (index * 3), value, sheet);
      });
    }
  }

  void _setTimeTableValue(int row, List<TimeTable> list, Worksheet sheet) {
    final columnList = [1, 3, 7, 11, 15, 19, 23];
    for (var timeTable in list) {
      final index = timeTable.day - 1;
      //Saat
      sheet.getRangeByIndex(row, columnList[index]).setText('Gun${timeTable.day}Saat');
      sheet.getRangeByIndex(row, columnList[index]).cellStyle.fontSize = 14;
      sheet.getRangeByIndex(row, columnList[index]).cellStyle.hAlign = HAlignType.center;
      sheet.getRangeByIndex(row, columnList[index]).cellStyle.vAlign = VAlignType.center;

      sheet.getRangeByIndex(row + 1, columnList[index]).setText('Gun${timeTable.day}Ders');
      sheet.getRangeByIndex(row + 1, columnList[index]).cellStyle.fontSize = 18;
      sheet.getRangeByIndex(row + 1, columnList[index]).cellStyle.bold = true;
      sheet.getRangeByIndex(row + 1, columnList[index]).cellStyle.hAlign = HAlignType.center;
      sheet.getRangeByIndex(row + 1, columnList[index]).cellStyle.vAlign = VAlignType.center;

      sheet.getRangeByIndex(row + 2, columnList[index]).setText('Gun${timeTable.day}Konu');
      sheet.getRangeByIndex(row + 2, columnList[index]).cellStyle.fontSize = 14;
      sheet.getRangeByIndex(row + 2, columnList[index]).cellStyle.hAlign = HAlignType.center;
      sheet.getRangeByIndex(row + 2, columnList[index]).cellStyle.vAlign = VAlignType.center;
    }
  }

// PAGE 1 <--

/*
  void _setStyles(Workbook workbook, Worksheet sheet) {
    //Style
    final Style studentInfoStyle = ExcelHelper.studentInfoStyle(workbook);
    final Style titleLargeStyle = ExcelHelper.titleLargeStyle(workbook: workbook);
    final Style titleMediumStyle = ExcelHelper.titleMediumStyle(workbook: workbook);
    final Style averageTitleStyle = ExcelHelper.averageTitleStyle(workbook: workbook);
    final Style averageValueStyle = ExcelHelper.averageValueStyle(workbook: workbook);

    sheet.getRangeByName('B3:M7').cellStyle = studentInfoStyle;
    sheet.getRangeByName('B1:Y1').cellStyle = titleLargeStyle;
    sheet.getRangeByName('B2:Y2').cellStyle = titleMediumStyle;
    sheet.getRangeByName('N3:Y7').cellStyle = studentInfoStyle;
    sheet.getRangeByName('B8:Y9').cellStyle = titleLargeStyle; // Ortalama Başlık Style
    sheet.getRangeByName('B10:Y11').cellStyle = averageTitleStyle; // Ortalama Ders Başlık Style
    sheet.getRangeByName('B12:Y12').cellStyle = averageValueStyle; // Öğrenci Ortalama Değerleri
    sheet.getRangeByName('B13:Y13').cellStyle = averageValueStyle; // Sınıf Ortalama Değerleri
    sheet.getRangeByName('B14:Y14').cellStyle = averageValueStyle; // Okul Ortalama Değerleri
  }

  void _setTitles(Worksheet sheet) {
    sheet.getRangeByName('B1').setText('YAVUZ SELİM ORTAOKULU');
    sheet.getRangeByName('B2').setText('DENEME SINAVLARI ÖĞRENCİ SONUÇ KARNESİ');
    sheet.getRangeByName('B8').setText('ORTALAMA');
  }

  void _setStudentInfo(Worksheet sheet, Student student) {
    sheet.getRangeByName('B3').setText('SINIFI');
    sheet.getRangeByName('E3').setText(':');
    sheet.getRangeByName('F3').setText(student.className); // Sınıfı

    // 4
    sheet.getRangeByName('B4').setText('ADI-SOYADI');
    sheet.getRangeByName('E4').setText(':');
    sheet.getRangeByName('F4').setText(student.studentName);

    // 5
    sheet.getRangeByName('B5').setText('NUMARASI');
    sheet.getRangeByName('E5').setText(':');
    sheet.getRangeByName('F5').setNumber(double.parse(student.studentNumber!));

    // 6
    sheet.getRangeByName('B6').setText('SINIF SIRASI');
    sheet.getRangeByName('E6').setText(':');
    sheet.getRangeByName('F6').setNumber(1);

    // 7
    sheet.getRangeByName('B7').setText('OKUL SIRASI');
    sheet.getRangeByName('E7').setText(':');
    sheet.getRangeByName('F7').setNumber(1);
  }

  void _setTotalNetGraph(Worksheet sheet, Worksheet sheet2, TrialExamGraph? totalNetGraph, ChartCollection charts) {
    if (totalNetGraph != null) {
      sheet2.getRangeByName('A1:B1').merge();
      sheet2.getRangeByName('A1').setText('Toplam');
      int i = 1;
      for (var totalNetItem in totalNetGraph.itemList) {
        i++;
        sheet2.getRangeByName('A$i').setText(totalNetItem.itemName);
        sheet2.getRangeByName('B$i').setNumber(totalNetItem.value);
      }

      // Set Graph

      final Chart chart = charts.add();
      chart.chartType = ExcelChartType.lineStacked;
      chart.dataRange = sheet2.getRangeByName('A2:B$i');
      chart.isSeriesInRows = false;
      chart.hasLegend = false;
      chart.primaryValueAxis.maximumValue = 100;
      chart.chartTitle = 'TOPLAM';
      chart.linePattern = ExcelChartLinePattern.solid;

      chart.topRow = 3;
      chart.bottomRow = 8;
      chart.leftColumn = 14;
      chart.rightColumn = 26;
    }
  }

  void _setAverages(Worksheet sheet, TrialExamStudentResult trialExamStudentResult,
      TrialExamAverageHelper classAverages, TrialExamAverageHelper schoolAverages) {
    // Main Title
    sheet.getRangeByName('B8:Y9').cellStyle.borders.all.color = '#A9D08E';
    sheet.getRangeByName('B13:Y13').cellStyle.backColor = '#C6E0B4';
    sheet.getRangeByName('B14:Y14').cellStyle.backColor = '#C6E0B4';

    //Merge Ortalama Başlıklar
    sheet.getRangeByName('B10:D11').merge(); // Sınav Adı
    sheet.getRangeByName('E10:G11').merge(); // Türkçe
    sheet.getRangeByName('H10:J11').merge(); // İnkılap
    sheet.getRangeByName('K10:M11').merge(); // Din
    sheet.getRangeByName('N10:P11').merge(); // İngilizce
    sheet.getRangeByName('Q10:S11').merge(); // Matematik
    sheet.getRangeByName('T10:V11').merge(); // Fen
    sheet.getRangeByName('W10:Y11').merge(); // Toplam

    //Merge Öğrenci Ortalaması
    sheet.getRangeByName('B12:D12').merge(); // Öğrenci Ortalaması
    sheet.getRangeByName('E12:F12').merge(); // Türkçe
    sheet.getRangeByName('H12:I12').merge(); // İnkılap
    sheet.getRangeByName('K12:L12').merge(); // Din
    sheet.getRangeByName('N12:O12').merge(); // İngilizce
    sheet.getRangeByName('Q12:R12').merge(); // Matematik
    sheet.getRangeByName('T12:U12').merge(); // Fen
    sheet.getRangeByName('W12:X12').merge(); // Toplam

    //Merge Sınıf Ortalaması
    sheet.getRangeByName('B13:D13').merge(); // Sınav Adı
    sheet.getRangeByName('E13:G13').merge(); // Türkçe
    sheet.getRangeByName('H13:J13').merge(); // İnkılap
    sheet.getRangeByName('K13:M13').merge(); // Din
    sheet.getRangeByName('N13:P13').merge(); // İngilizce
    sheet.getRangeByName('Q13:S13').merge(); // Matematik
    sheet.getRangeByName('T13:V13').merge(); // Fen
    sheet.getRangeByName('W13:Y13').merge(); // Toplam

    //Merge Okul Ortalaması
    sheet.getRangeByName('B14:D14').merge(); // Sınav Adı
    sheet.getRangeByName('E14:G14').merge(); // Türkçe
    sheet.getRangeByName('H14:J14').merge(); // İnkılap
    sheet.getRangeByName('K14:M14').merge(); // Din
    sheet.getRangeByName('N14:P14').merge(); // İngilizce
    sheet.getRangeByName('Q14:S14').merge(); // Matematik
    sheet.getRangeByName('T14:V14').merge(); // Fen
    sheet.getRangeByName('W14:Y14').merge(); // Toplam

    sheet.getRangeByName('B10').setText('ORTALAMA TÜRÜ');
    sheet.getRangeByName('E10').setText('TÜRKÇE');
    sheet.getRangeByName('H10').setText('SOSYAL');
    sheet.getRangeByName('K10').setText('DİN');
    sheet.getRangeByName('N10').setText('İNGİLİZCE');
    sheet.getRangeByName('Q10').setText('MATEMATİK');
    sheet.getRangeByName('T10').setText('FEN');
    sheet.getRangeByName('W10').setText('TOPLAM');

    // Öğrenci Ortalaması:

    sheet.getRangeByName('B12').setText('Öğrenci Ort.');
    sheet.getRangeByName('E12').setNumber(trialExamStudentResult.turNetAvg);
    sheet.getRangeByName('H12').setNumber(trialExamStudentResult.sosNetAvg);
    sheet.getRangeByName('K12').setNumber(trialExamStudentResult.dinNetAvg);
    sheet.getRangeByName('N12').setNumber(trialExamStudentResult.ingNetAvg);
    sheet.getRangeByName('Q12').setNumber(trialExamStudentResult.matNetAvg);
    sheet.getRangeByName('T12').setNumber(trialExamStudentResult.fenNetAvg);
    sheet.getRangeByName('W12').setNumber(trialExamStudentResult.totNetAvg);

    //Set Icons
    sheet.getRangeByName('G12').setText('▲');
    sheet.getRangeByName('J12').setText('▲');
    sheet.getRangeByName('M12').setText('▲');
    sheet.getRangeByName('P12').setText('▲');
    sheet.getRangeByName('S12').setText('▲');
    sheet.getRangeByName('V12').setText('▲');
    sheet.getRangeByName('Y12').setText('▲');

    if (trialExamStudentResult.turNetAvg < schoolAverages.turAvg) {
      sheet.getRangeByName('E12:G12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('G12').setText('▼');
    }

    if (trialExamStudentResult.sosNetAvg < schoolAverages.sosAvg) {
      sheet.getRangeByName('H12:J12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('J12').setText('▼');
    }

    if (trialExamStudentResult.dinNetAvg < schoolAverages.dinAvg) {
      sheet.getRangeByName('K12:M12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('M12').setText('▼');
    }

    if (trialExamStudentResult.ingNetAvg < schoolAverages.ingAvg) {
      sheet.getRangeByName('N12:P12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('P12').setText('▼');
    }

    if (trialExamStudentResult.matNetAvg < schoolAverages.matAvg) {
      sheet.getRangeByName('Q12:S12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('S12').setText('▼');
    }

    if (trialExamStudentResult.fenNetAvg < schoolAverages.fenAvg) {
      sheet.getRangeByName('T12:V12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('V12').setText('▼');
    }

    if (trialExamStudentResult.totNetAvg < schoolAverages.totAvg) {
      sheet.getRangeByName('W12:Y12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('Y12').setText('▼');
    }

    /*

      sheet.getRangeByName('F14:H14').merge(); // Türkçe
    sheet.getRangeByName('I14:K14').merge(); // İnkılap
    sheet.getRangeByName('L14:N14').merge(); // Din
    sheet.getRangeByName('O14:Q14').merge(); // İngilizce
    sheet.getRangeByName('R14:T14').merge(); // Matematik
    sheet.getRangeByName('U14:W14').merge(); // Fen
    sheet.getRangeByName('X14:Z14').merge(); // Toplam
    */

    //sheet.getRangeByName('K12').setText('▼');

    // Sınıf Ortalaması:
    sheet.getRangeByName('B13').setText('Sınıf Ort.');

    sheet.getRangeByName('E13').setNumber(classAverages.turAvg);
    sheet.getRangeByName('H13').setNumber(classAverages.sosAvg);
    sheet.getRangeByName('K13').setNumber(classAverages.dinAvg);
    sheet.getRangeByName('N13').setNumber(classAverages.ingAvg);
    sheet.getRangeByName('Q13').setNumber(classAverages.matAvg);
    sheet.getRangeByName('T13').setNumber(classAverages.fenAvg);
    sheet.getRangeByName('W13').setNumber(classAverages.totAvg);

    // Okul Ortalaması:
    sheet.getRangeByName('B14').setText('Okul Ort.');
    sheet.getRangeByName('E14').setNumber(schoolAverages.turAvg);
    sheet.getRangeByName('H14').setNumber(schoolAverages.sosAvg);
    sheet.getRangeByName('K14').setNumber(schoolAverages.dinAvg);
    sheet.getRangeByName('N14').setNumber(schoolAverages.ingAvg);
    sheet.getRangeByName('Q14').setNumber(schoolAverages.matAvg);
    sheet.getRangeByName('T14').setNumber(schoolAverages.fenAvg);
    sheet.getRangeByName('W14').setNumber(schoolAverages.totAvg);

    // styles:
  }

  void _setLessonCharts(
      Worksheet sheet, Worksheet sheet2, List<TrialExamGraph> studentTrialExamGraphList, ChartCollection charts) {
    //Merge
    sheet.getRangeByName('B15:Y42').merge(); // Sınav Adı
    sheet2.getRangeByName('C1:D1').merge();
    sheet2.getRangeByName('E1:F1').merge();
    sheet2.getRangeByName('G1:H1').merge();
    sheet2.getRangeByName('I1:J1').merge();
    sheet2.getRangeByName('K1:L1').merge();
    sheet2.getRangeByName('M1:N1').merge();

    int column = 3;
    for (var examGraph in studentTrialExamGraphList) {
      sheet2.getRangeByIndex(1, column).setText(examGraph.graphLabelName);
      int row = 2;
      for (var examItem in examGraph.itemList) {
        sheet2.getRangeByIndex(row, column).setText(examItem.itemName);
        sheet2.getRangeByIndex(row, column + 1).setNumber(examItem.value);
        row++;
      }
      _addLessonChart(examGraph, column, row, sheet, sheet2, charts);
      column = column + 2;
    }

/*
    for (var i = 0; i < studentTrialExamGraphList.length; i++) {
      final graph = studentTrialExamGraphList[i];
      for (var j = 0; j < graph.itemList.length; i++) {
          final graphItem = graph.itemList[j];
          sheet2.getRangeByIndex(i + 3, i + 3).setText(item.);
        
      }
      
    }
    */
  }

  void _addLessonChart(
      TrialExamGraph examGraph, int column, int row, Worksheet sheet, Worksheet sheet2, ChartCollection charts) {
    final Chart chart = charts.add();
    //chart.primaryValueAxis.minimumValue = 0.0;
    chart.primaryValueAxis.maximumValue = examGraph.lessonType == LessonType.twenty ? 20.0 : 10.0;
    chart.chartType = ExcelChartType.lineStacked;
    chart.dataRange = sheet2.getRangeByIndex(2, column, row - 1, column + 1);
    chart.isSeriesInRows = false;
    chart.hasLegend = false;
    chart.chartTitle = examGraph.graphLabelName;
    chart.chartTitleArea.size = 12;
    chart.chartTitleArea.bold = true;

    chart.linePattern = ExcelChartLinePattern.solid;

    int s1 = 2;
    int s2 = 10;
    int s3 = 18;
    int r1 = 15;
    int r2 = 29;
    int graphWidth = 8;
    int graphHeight = 14;

    //final lessonColors = <String>['#F05255','#FDC02F', '#50AE55', '#48C5FC', '#DE4BF8', '#159588'];
    final lessonColors = <String>['#EB7D3C', '#BF9021', '#BE0712', '#1AAF54', '#833C15', '#5E9CD3'];

    switch (column) {
      case 3:
        chart.leftColumn = s1;
        chart.rightColumn = s1 + graphWidth;
        chart.topRow = r1;
        chart.bottomRow = r1 + graphHeight;
        chart.chartTitleArea.color = lessonColors[0];
        chart.primaryValueAxis.titleArea.color = lessonColors[0];
        chart.primaryCategoryAxis.titleArea.color = lessonColors[0];

        break;
      case 5:
        chart.leftColumn = s2;
        chart.rightColumn = s2 + graphWidth;
        chart.topRow = r1;
        chart.bottomRow = r1 + graphHeight;
        chart.chartTitleArea.color = lessonColors[1];
        chart.primaryValueAxis.titleArea.color = lessonColors[1];
        chart.primaryCategoryAxis.titleArea.color = lessonColors[1];

        break;

      case 7:
        chart.leftColumn = s3;
        chart.rightColumn = s3 + graphWidth;
        chart.topRow = r1;
        chart.bottomRow = r1 + graphHeight;
        chart.chartTitleArea.color = lessonColors[2];
        chart.primaryValueAxis.titleArea.color = lessonColors[2];
        chart.primaryCategoryAxis.titleArea.color = lessonColors[2];
        break;

      case 9:
        chart.leftColumn = s1;
        chart.rightColumn = s1 + graphWidth;
        chart.topRow = r2;
        chart.bottomRow = r2 + graphHeight;
        chart.chartTitleArea.color = lessonColors[3];
        chart.primaryValueAxis.titleArea.color = lessonColors[3];
        chart.primaryCategoryAxis.titleArea.color = lessonColors[3];
        break;

      case 11:
        chart.leftColumn = s2;
        chart.rightColumn = s2 + graphWidth;
        chart.topRow = r2;
        chart.bottomRow = r2 + graphHeight;
        chart.chartTitleArea.color = lessonColors[4];
        chart.primaryValueAxis.titleArea.color = lessonColors[4];
        chart.primaryCategoryAxis.titleArea.color = lessonColors[4];
        break;
      case 13:
        chart.leftColumn = s3;
        chart.rightColumn = s3 + graphWidth;
        chart.topRow = r2;
        chart.bottomRow = r2 + graphHeight;
        chart.chartTitleArea.color = lessonColors[5];
        chart.primaryValueAxis.titleArea.color = lessonColors[5];
        chart.primaryCategoryAxis.titleArea.color = lessonColors[5];
        break;
      default:
    }
  }

  void _setExamResults(Worksheet sheet, List<TrialExamResult>? studentTrialExamResultList, Workbook workbook) {
    final Style examResultTitleStyle = ExcelHelper.examResultTitle(workbook: workbook);

    // Styles :
    sheet.getRangeByName('B44:Y45').cellStyle = examResultTitleStyle;
    sheet.getRangeByName('B44').setText('Sınav Adı');

    int row = 44;
    int startCol = 5;
    int endCol = 7;
    sheet.getRangeByName('B44:D45').merge();
    for (var i = 0; i < 7; i++) {
      sheet.getRangeByIndex(row, startCol, row, endCol).merge();
      sheet.getRangeByIndex(row, startCol).setText(_getResultTitle(i));
      startCol = startCol + 3;
      endCol = endCol + 3;
    }

    _setDYN(sheet);

    _setValue(studentTrialExamResultList, sheet, workbook);
  }

  void _setValue(List<TrialExamResult>? studentTrialExamResultList, Worksheet sheet, Workbook workbook) {
    final Style examResultValue1Style = ExcelHelper.examResultValue1(workbook: workbook);
    final Style examResultValue2Style = ExcelHelper.examResultValue2(workbook: workbook);
    int row = 46;
    const int startCol = 2;
    const int endCol = 4;

    if (studentTrialExamResultList != null && studentTrialExamResultList.isNotEmpty) {
      for (var examResult in studentTrialExamResultList) {
        if (row % 2 == 0) {
          sheet.getRangeByIndex(row, 2, row, 25).cellStyle = examResultValue1Style;
        } else {
          sheet.getRangeByIndex(row, 2, row, 25).cellStyle = examResultValue2Style;
        }

        List<num> numList = <num>[
          examResult.turDog!,
          examResult.turYan!,
          examResult.turNet!,
          examResult.sosDog!,
          examResult.sosYan!,
          examResult.sosNet!,
          examResult.ingDog!,
          examResult.ingYan!,
          examResult.ingNet!,
          examResult.dinDog!,
          examResult.dinYan!,
          examResult.dinNet!,
          examResult.matDog!,
          examResult.matYan!,
          examResult.matNet!,
          examResult.fenDog!,
          examResult.fenYan!,
          examResult.fenNet!,
          _totalDog(examResult),
          _totalYan(examResult),
          _totalNet(examResult),
        ];
        // Exam Name:
        sheet.getRangeByIndex(row, startCol, row, endCol).merge();
        sheet.getRangeByIndex(row, startCol).setText(examResult.trialExam!.examName);

        var stCol = 5;

        for (var i = 0; i < numList.length; i++) {
          sheet.getRangeByIndex(row, stCol).setNumber(numList[i].toDouble());
          stCol++;
        }

        row++;

        //
      }
    }
  }

  String _getResultTitle(int i) {
    var title = '';
    switch (i) {
      case 0:
        title = 'Türkçe';
        break;

      case 1:
        title = 'Sosyal';
        break;

      case 2:
        title = 'İngilizce';
        break;

      case 3:
        title = 'Din';
        break;

      case 4:
        title = 'Matematik';
        break;

      case 5:
        title = 'Fen';
        break;

      case 6:
        title = 'Toplam';
        break;
    }

    return title;
  }

  void _setDYN(Worksheet sheet) {
    int row = 45;
    int startCol = 5;
    for (var i = 1; i < 22; i++) {
      var range = i % 3;
      if (range == 1) {
        sheet.getRangeByIndex(row, startCol).setText('D');
        //sheet.getRangeByIndex(row, startCol).cellStyle = averageTitleStyle;
      } else if (range == 2) {
        sheet.getRangeByIndex(row, startCol).setText('Y');
      } else {
        sheet.getRangeByIndex(row, startCol).setText('N');
      }
      startCol++;
    }
  }

  int _totalDog(TrialExamResult examResult) {
    return examResult.turDog! +
        examResult.sosDog! +
        examResult.ingDog! +
        examResult.dinDog! +
        examResult.matDog! +
        examResult.fenDog!;
  }

  int _totalYan(TrialExamResult examResult) {
    return examResult.turYan! +
        examResult.sosYan! +
        examResult.ingYan! +
        examResult.dinYan! +
        examResult.matYan! +
        examResult.fenYan!;
  }

  double _totalNet(TrialExamResult examResult) {
    return examResult.turNet! +
        examResult.sosNet! +
        examResult.ingNet! +
        examResult.dinNet! +
        examResult.matNet! +
        examResult.fenNet!;
  }

  */
}

/*

  // Setting value in the cell.
    sheet.getRangeByName('A1').setText('City Name');
    sheet.getRangeByName('A2').setText('Chennai');
    sheet.getRangeByName('A3').setText('Mumbai');
    sheet.getRangeByName('A4').setText('Delhi');
    sheet.getRangeByName('A5').setText('Hyderabad');
    sheet.getRangeByName('A6').setText('Kolkata');
    sheet.getRangeByName('B1').setText('Temp in C');
    sheet.getRangeByName('B2').setNumber(34);
    sheet.getRangeByName('B3').setNumber(40);
    sheet.getRangeByName('B4').setNumber(47);
    sheet.getRangeByName('B5').setNumber(20);
    sheet.getRangeByName('B6').setNumber(66);

// Create an instances of chart collection.
    final ChartCollection charts = ChartCollection(sheet);

// Add the chart.
    final Chart chart = charts.add();

//Set Chart Type.
    chart.chartType = ExcelChartType.line;

//Set data range in the worksheet.
    chart.dataRange = sheet.getRangeByName('A1:B6');
    chart.isSeriesInRows = false;
    chart.hasLegend = false;
    chart.topRow = 20;
    chart.bottomRow = 30;
    chart.leftColumn = 1;
    chart.rightColumn = 4;

// set charts to worksheet.
    sheet.charts = charts;

*/
