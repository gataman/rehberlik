import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/helper/trial_exam_graph/trial_exam_graph.dart';
import 'package:rehberlik/models/helpers/trial_exam_average_helper.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/trial_exam_student_result.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:syncfusion_officechart/officechart.dart';

import '../../../views/admin/admin_student_trial_exam_detail_view/cubit/student_trial_exam_detail_cubit.dart';
import '../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import 'excel_helper.dart';

class StudentTrialExamExcelCreator {
  final ValueNotifier<bool> notifier = ValueNotifier(false);
  final BuildContext context;

  StudentTrialExamExcelCreator(this.context);

  Future<void> build() async {
    final student = context.read<StudentTrialExamDetailCubit>().selectedStudent;
    final studentTrialExamResultList = context.read<StudentTrialExamDetailCubit>().studentTrialExamResultList;
    final studentTrialExamGraphList = context.read<StudentTrialExamDetailCubit>().studentTrialExamGraphList;
    final trialExamStudentResult = context.read<StudentTrialExamDetailCubit>().trialExamStudentResult;
    final totalNetGraph = context.read<StudentTrialExamDetailCubit>().totalNetGraph;
    final classAverages = context.read<StudentTrialExamDetailCubit>().classAverages;
    final schoolAverages = context.read<StudentTrialExamDetailCubit>().schoolAverages;

    final Workbook workbook = Workbook(2);

    final Worksheet sheet = workbook.worksheets[0];
    final Worksheet sheet2 = workbook.worksheets[1];
    sheet.name = 'Öğrenci Karnesi';
    sheet2.name = 'Veriler';
    //sheet2.visibility = WorksheetVisibility.hidden;

    //sheet.showGridlines = false;
    //sheet.enableSheetCalculations();

    //Set width
    sheet.getRangeByName('A1:D1').columnWidth = 4;
    sheet.getRangeByName('E1').columnWidth = 8.5;
    sheet.getRangeByName('F1:Z1').columnWidth = 4.67;

    //Set height
    sheet.getRangeByName('A1').rowHeight = 20;
    sheet.getRangeByName('A2').rowHeight = 14.25;
    sheet.getRangeByName('A3:A7').rowHeight = 30;
    //sheet.getRangeByName('A8:A9').showRows(false);

    //Merge
    sheet.getRangeByName('B1:Z1').merge();
    sheet.getRangeByName('B2:Z2').merge();

    sheet.getRangeByName('B3:E3').merge();
    sheet.getRangeByName('B4:E4').merge();
    sheet.getRangeByName('B5:E5').merge();
    sheet.getRangeByName('B6:E6').merge();
    sheet.getRangeByName('B7:E7').merge();

    sheet.getRangeByName('B8:Z9').merge();

    sheet.getRangeByName('G3:N3').merge();
    sheet.getRangeByName('G4:N4').merge();
    sheet.getRangeByName('G5:N5').merge();
    sheet.getRangeByName('G6:N6').merge();
    sheet.getRangeByName('G7:N7').merge();
    sheet.getRangeByName('O3:Z7').merge();

    //Style
    final Style studentInfoStyle = ExcelHelper.studentInfoStyle(workbook);
    final Style titleLargeStyle = ExcelHelper.titleLargeStyle(workbook: workbook);
    final Style titleMediumStyle = ExcelHelper.titleMediumStyle(workbook: workbook);
    final Style averageTitleStyle = ExcelHelper.averageTitleStyle(workbook: workbook);
    final Style averageValueStyle = ExcelHelper.averageValueStyle(workbook: workbook);

    sheet.getRangeByName('B3:N7').cellStyle = studentInfoStyle;
    sheet.getRangeByName('B1:Z1').cellStyle = titleLargeStyle;
    sheet.getRangeByName('B2:Z2').cellStyle = titleMediumStyle;
    sheet.getRangeByName('O3:Z7').cellStyle = studentInfoStyle;
    sheet.getRangeByName('B8:Z9').cellStyle = titleLargeStyle; // Ortalama Başlık Style
    sheet.getRangeByName('B10:Z11').cellStyle = averageTitleStyle; // Ortalama Ders Başlık Style
    sheet.getRangeByName('B12:Z12').cellStyle = averageValueStyle; // Öğrenci Ortalama Değerleri
    sheet.getRangeByName('B13:Z13').cellStyle = averageValueStyle; // Sınıf Ortalama Değerleri
    sheet.getRangeByName('B14:Z14').cellStyle = averageValueStyle; // Okul Ortalama Değerleri

    //Titles
    _setTitles(sheet);

    // StudentInfo
    _setStudentInfo(sheet, student!);

    // Set Total Net
    _setTotalNetGraph(sheet, sheet2, totalNetGraph);

    //Averages
    _setAverages(sheet, trialExamStudentResult!, classAverages!, schoolAverages!);

    // Charts
    _setLessonCharts(sheet, sheet2, studentTrialExamGraphList);

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    //Save and launch the file.
    await FileSaveHelper.saveAndLaunchFile(bytes, '${student.studentNumber}.xlsx');
    notifier.value = false;
  }

  void _setTitles(Worksheet sheet) {
    sheet.getRangeByName('B1').setText('YAVUZ SELİM ORTAOKULU');
    sheet.getRangeByName('B2').setText('DENEME SINAVLARI ÖĞRENCİ SONUÇ KARNESİ');
    sheet.getRangeByName('B8').setText('ORTALAMA');
  }

  void _setStudentInfo(Worksheet sheet, Student student) {
    sheet.getRangeByName('B3').setText('SINIFI');
    sheet.getRangeByName('F3').setText(':');
    sheet.getRangeByName('G3').setText(student.className); // Sınıfı

    // 4
    sheet.getRangeByName('B4').setText('ADI-SOYADI');
    sheet.getRangeByName('F4').setText(':');
    sheet.getRangeByName('G4').setText(student.studentName);

    // 5
    sheet.getRangeByName('B5').setText('NUMARASI');
    sheet.getRangeByName('F5').setText(':');
    sheet.getRangeByName('G5').setNumber(double.parse(student.studentNumber!));

    // 6
    sheet.getRangeByName('B6').setText('SINIF SIRASI');
    sheet.getRangeByName('F6').setText(':');
    sheet.getRangeByName('G6').setNumber(1);

    // 7
    sheet.getRangeByName('B7').setText('OKUL SIRASI');
    sheet.getRangeByName('F7').setText(':');
    sheet.getRangeByName('G7').setNumber(1);
  }

  void _setTotalNetGraph(Worksheet sheet, Worksheet sheet2, TrialExamGraph? totalNetGraph) {
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
      final ChartCollection charts = ChartCollection(sheet);

      final Chart chart = charts.add();
      chart.chartType = ExcelChartType.lineStacked;
      chart.dataRange = sheet2.getRangeByName('A2:B$i');
      chart.isSeriesInRows = false;
      chart.hasLegend = false;
      chart.primaryValueAxis.maximumValue = 100;
      chart.primaryValueAxis.minimumValue = 0;
      chart.chartTitle = 'TOPLAM';
      chart.linePattern = ExcelChartLinePattern.solid;

      chart.topRow = 3;
      chart.bottomRow = 8;
      chart.leftColumn = 15;
      chart.rightColumn = 27;
      sheet.charts = charts;
    }
  }

  void _setAverages(
    Worksheet sheet,
    TrialExamStudentResult trialExamStudentResult,
    TrialExamAverageHelper classAverages,
    TrialExamAverageHelper schoolAverages,
  ) {
    // Main Title
    sheet.getRangeByName('B8:Z9').cellStyle.borders.all.color = '#A9D08E';
    sheet.getRangeByName('B13:Z13').cellStyle.backColor = '#C6E0B4';
    sheet.getRangeByName('B14:Z14').cellStyle.backColor = '#C6E0B4';

    //Merge Ortalama Başlıklar
    sheet.getRangeByName('B10:E11').merge(); // Sınav Adı
    sheet.getRangeByName('F10:H11').merge(); // Türkçe
    sheet.getRangeByName('I10:K11').merge(); // İnkılap
    sheet.getRangeByName('L10:N11').merge(); // Din
    sheet.getRangeByName('O10:Q11').merge(); // İngilizce
    sheet.getRangeByName('R10:T11').merge(); // Matematik
    sheet.getRangeByName('U10:W11').merge(); // Fen
    sheet.getRangeByName('X10:Z11').merge(); // Toplam

    //Merge Öğrenci Ortalaması
    sheet.getRangeByName('B12:E12').merge(); // Öğrenci Ortalaması
    sheet.getRangeByName('F12:G12').merge(); // Türkçe
    sheet.getRangeByName('I12:J12').merge(); // İnkılap
    sheet.getRangeByName('L12:M12').merge(); // Din
    sheet.getRangeByName('O12:P12').merge(); // İngilizce
    sheet.getRangeByName('R12:S12').merge(); // Matematik
    sheet.getRangeByName('U12:V12').merge(); // Fen
    sheet.getRangeByName('X12:Y12').merge(); // Toplam

    //Merge Sınıf Ortalaması
    sheet.getRangeByName('B13:E13').merge(); // Sınav Adı
    sheet.getRangeByName('F13:H13').merge(); // Türkçe
    sheet.getRangeByName('I13:K13').merge(); // İnkılap
    sheet.getRangeByName('L13:N13').merge(); // Din
    sheet.getRangeByName('O13:Q13').merge(); // İngilizce
    sheet.getRangeByName('R13:T13').merge(); // Matematik
    sheet.getRangeByName('U13:W13').merge(); // Fen
    sheet.getRangeByName('X13:Z13').merge(); // Toplam

    //Merge Okul Ortalaması
    sheet.getRangeByName('B14:E14').merge(); // Sınav Adı
    sheet.getRangeByName('F14:H14').merge(); // Türkçe
    sheet.getRangeByName('I14:K14').merge(); // İnkılap
    sheet.getRangeByName('L14:N14').merge(); // Din
    sheet.getRangeByName('O14:Q14').merge(); // İngilizce
    sheet.getRangeByName('R14:T14').merge(); // Matematik
    sheet.getRangeByName('U14:W14').merge(); // Fen
    sheet.getRangeByName('X14:Z14').merge(); // Toplam

    sheet.getRangeByName('B10').setText('ORTALAMA TÜRÜ');
    sheet.getRangeByName('F10').setText('TÜRKÇE');
    sheet.getRangeByName('I10').setText('SOSYAL');
    sheet.getRangeByName('L10').setText('DİN');
    sheet.getRangeByName('O10').setText('İNGİLİZCE');
    sheet.getRangeByName('R10').setText('MATEMATİK');
    sheet.getRangeByName('U10').setText('FEN');
    sheet.getRangeByName('X10').setText('TOPLAM');

    // Öğrenci Ortalaması:

    sheet.getRangeByName('B12').setText('Öğrenci Ort.');
    sheet.getRangeByName('F12').setNumber(trialExamStudentResult.turAvg);
    sheet.getRangeByName('I12').setNumber(trialExamStudentResult.sosAvg);
    sheet.getRangeByName('L12').setNumber(trialExamStudentResult.dinAvg);
    sheet.getRangeByName('O12').setNumber(trialExamStudentResult.ingAvg);
    sheet.getRangeByName('R12').setNumber(trialExamStudentResult.matAvg);
    sheet.getRangeByName('U12').setNumber(trialExamStudentResult.fenAvg);
    sheet.getRangeByName('X12').setNumber(trialExamStudentResult.totAvg);

    //Set Icons
    sheet.getRangeByName('H12').setText('▲');
    sheet.getRangeByName('K12').setText('▲');
    sheet.getRangeByName('N12').setText('▲');
    sheet.getRangeByName('H12').setText('▲');
    sheet.getRangeByName('T12').setText('▲');
    sheet.getRangeByName('W12').setText('▲');
    sheet.getRangeByName('Z12').setText('▲');

    if (trialExamStudentResult.turAvg < schoolAverages.turAvg) {
      sheet.getRangeByName('F12:H12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('H12').setText('▼');
    }

    if (trialExamStudentResult.sosAvg < schoolAverages.sosAvg) {
      sheet.getRangeByName('I12:K12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('K12').setText('▼');
    }

    if (trialExamStudentResult.dinAvg < schoolAverages.dinAvg) {
      sheet.getRangeByName('L12:N12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('N12').setText('▼');
    }

    if (trialExamStudentResult.ingAvg < schoolAverages.ingAvg) {
      sheet.getRangeByName('O12:Q12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('Q12').setText('▼');
    }

    if (trialExamStudentResult.matAvg < schoolAverages.matAvg) {
      sheet.getRangeByName('R12:T12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('T12').setText('▼');
    }

    if (trialExamStudentResult.fenAvg < schoolAverages.fenAvg) {
      sheet.getRangeByName('U12:W12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('W12').setText('▼');
    }

    if (trialExamStudentResult.totAvg < schoolAverages.totAvg) {
      sheet.getRangeByName('X12:Z12').cellStyle.fontColor = '#C00001';
      sheet.getRangeByName('Z12').setText('▼');
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

    sheet.getRangeByName('F13').setNumber(classAverages.turAvg);
    sheet.getRangeByName('I13').setNumber(classAverages.sosAvg);
    sheet.getRangeByName('L13').setNumber(classAverages.dinAvg);
    sheet.getRangeByName('O13').setNumber(classAverages.ingAvg);
    sheet.getRangeByName('R13').setNumber(classAverages.matAvg);
    sheet.getRangeByName('U13').setNumber(classAverages.fenAvg);
    sheet.getRangeByName('X13').setNumber(classAverages.totAvg);

    // Okul Ortalaması:
    sheet.getRangeByName('B14').setText('Okul Ort.');
    sheet.getRangeByName('F14').setNumber(schoolAverages.turAvg);
    sheet.getRangeByName('I14').setNumber(schoolAverages.sosAvg);
    sheet.getRangeByName('L14').setNumber(schoolAverages.dinAvg);
    sheet.getRangeByName('O14').setNumber(schoolAverages.ingAvg);
    sheet.getRangeByName('R14').setNumber(schoolAverages.matAvg);
    sheet.getRangeByName('U14').setNumber(schoolAverages.fenAvg);
    sheet.getRangeByName('X14').setNumber(schoolAverages.totAvg);

    debugPrint(trialExamStudentResult.toString());

    // styles:
  }

  void _setLessonCharts(Worksheet sheet, Worksheet sheet2, List<TrialExamGraph> studentTrialExamGraphList) {
    //Merge
    sheet.getRangeByName('B15:Z40').merge(); // Sınav Adı
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
      _addLessonChart(examGraph, column, row, sheet, sheet2);
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

    debugPrint(studentTrialExamGraphList.toString());
  }

  void _addLessonChart(TrialExamGraph examGraph, int column, int row, Worksheet sheet, Worksheet sheet2) {
    final ChartCollection charts = ChartCollection(sheet);
    debugPrint('Column ${column.toString()}');
    debugPrint('Row ${row.toString()}');
    debugPrint('______________');

    final Chart chart = charts.add();
    chart.chartType = ExcelChartType.lineStacked;
    chart.dataRange = sheet2.getRangeByIndex(2, column, row - 1, column + 1);
    chart.isSeriesInRows = false;
    chart.hasLegend = false;
    chart.primaryValueAxis.maximumValue = 20;
    chart.primaryValueAxis.minimumValue = 0;
    chart.chartTitle = examGraph.graphLabelName;
    chart.linePattern = ExcelChartLinePattern.solid;

    chart.topRow = 30;
    chart.bottomRow = 38;
    chart.leftColumn = 15;
    chart.rightColumn = 27;
    sheet.charts = charts;
  }
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
