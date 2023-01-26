import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../models/student_with_class.dart';
import '../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';

class StudentPasswordExcelCrator {
  final ValueNotifier<bool> notifier = ValueNotifier(false);
  final BuildContext context;
  //late StudentDetailExcelHelper _helper;

  StudentPasswordExcelCrator(this.context) {
    // _helper = StudentDetailExcelHelper();
  }

  Future<void> build(List<StudentWithClass> classesList) async {
    final Workbook workbook = Workbook(1);
    final Worksheet sheet = workbook.worksheets[0];
    _pageSetup(sheet);
    sheet.getRangeByName('B1').columnWidth = 25.0;
    sheet.getRangeByName('c1').columnWidth = 20.0;

    var row = 1;
    for (var studentWithClasses in classesList) {
      for (var student in studentWithClasses.studentList!) {
        sheet.getRangeByIndex(row, 1).setNumber(double.parse(student.studentNumber!));
        sheet.getRangeByIndex(row, 2).setText(student.studentName);
        sheet.getRangeByIndex(row, 3).setText(student.password);
        row++;
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.

    //Save and launch the file.
    await FileSaveHelper.saveAndLaunchFile(bytes, 'ogrenci_sifreleri.xlsx');
    notifier.value = false;
    workbook.dispose();
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
}
