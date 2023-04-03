import 'package:flutter/material.dart';
import '../../../extensions.dart';
import '../../../locator.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../models/student.dart';
import '../../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import 'exam_hall_builder.dart';
import '../student_detail_excel_builder/student_detail_excel_helper.dart';

class StudentHallListCreator {
  final ValueNotifier<bool> notifier = ValueNotifier(false);

  late StudentDetailExcelHelper _helper;

  StudentHallListCreator() {
    _helper = locator<StudentDetailExcelHelper>();
  }

  Future<void> build(List<Student> studentList) async {
    notifier.value = true;

    final map = studentList.groupBy((element) => element.salonNo);

    debugPrint(map.length.toString());

    final Workbook workbook = Workbook(map.length);

    var hallOrder = 0;
    map.forEach((salonNo, studentList) {
      final Worksheet sheet = workbook.worksheets[hallOrder];
      _pageSetup(sheet, salonNo!);

      var row = 0;
      for (var student in studentList) {
        _addStudent(sheet: sheet, student: student, row: row);

        row++;
      }
      hallOrder++;
    });

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.

    //Save and launch the file.
    await FileSaveHelper.saveAndLaunchFile(bytes, 'salon_bilgileri.xlsx');
    notifier.value = false;
    workbook.dispose();
  }

  void _pageSetup(Worksheet sheet, String hall) {
    sheet.name = hall;
    var pageSetup = sheet.pageSetup;

    pageSetup.leftMargin = .25;
    pageSetup.rightMargin = .25;
    pageSetup.topMargin = .25;
    pageSetup.bottomMargin = .20;
    pageSetup.orientation = ExcelPageOrientation.portrait;

    //sheet.getRangeByIndex(1, 1, 1, 35).columnWidth = 2.17;
    //sheet.getRangeByName('C1').columnWidth = 0.62;
    //sheet.getRangeByName('G1').columnWidth = 0.62;
  }

  void _addStudent({
    required Worksheet sheet,
    required Student student,
    required int row,
  }) {
    final siraNoCell = sheet.getRangeByIndex(row + 1, 1);
    siraNoCell.setNumber(double.parse(student.siraNo!));

    final ogrenciNoCell = sheet.getRangeByIndex(row + 1, 2);
    ogrenciNoCell.setText(student.studentNumber);

    final ogrencAdiCell = sheet.getRangeByIndex(row + 1, 3);
    ogrencAdiCell.setText(student.studentName);

    final ogrenciSinifCell = sheet.getRangeByIndex(row + 1, 4);
    ogrenciSinifCell.setText(student.className);
  }
}
