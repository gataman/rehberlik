import 'package:intl/intl.dart';
import 'package:rehberlik/common/helper.dart';
import 'package:rehberlik/common/helper/pdf_creator/pdf_helper.dart';
import 'package:rehberlik/common/helper/save_file_mobile.dart'
    if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import 'package:rehberlik/models/helpers/lesson_with_subject.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_imports.dart';
import 'package:rehberlik/views/admin/admin_student_detail/study_program/admin_study_program_controller.dart';
import 'package:rehberlik/views/admin/admin_student_detail/time_table/student_time_table_controller.dart';

class StudentDetailPdfBuilder {
  final ValueNotifier<bool> notifier = ValueNotifier(false);
  final _timeTableController = Get.put(StudentTimeTableController());
  final _programController = Get.put(AdminStudyProgramController());

  Future<void> build(Student student) async {
    var timeTableList = _timeTableController.timeTableList.value;
    timeTableList ??=
        await _timeTableController.getAllTimeTable(student: student);

    var programList = _programController.programList.value;
    programList ??=
        await _programController.getAllPrograms(studentID: student.id!);

    final PdfDocument pdfDocument = PdfDocument();
    pdfDocument.pageSettings.orientation = PdfPageOrientation.landscape;

    final PdfPage page = pdfDocument.pages.add();

    final Size pageSize = page.getClientSize();

    //final PdfGrid grid = _getGrid();

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));

    //Başlık
    await _drawHeader(page, pageSize);

    await _drawStudentInfoBox(page, student);
    //await _drawStudentTarget(page);

    await _drawStudentProgram(page, programList);
    if (timeTableList != null) {
      await _drawStudentTimeTable(page, timeTableList);
    }

    final List<int> bytes = await pdfDocument.save();
    pdfDocument.dispose();
    await FileSaveHelper.saveAndLaunchFile(
        bytes, '${student.studentNumber}.pdf');
    notifier.value = false;
  }

  Future<void> _drawHeader(PdfPage page, Size pageSize) async {
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 40));
    //Draw string
    page.graphics.drawString('HAFTALIK ÇALIŞMA PLANIM',
        await PdfHelper.getPdfFont(size: 18, isBold: true),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 40),
        format: PdfStringFormat(
            lineAlignment: PdfVerticalAlignment.middle,
            alignment: PdfTextAlignment.center));
  }

  Future<void> _drawStudentInfoBox(PdfPage page, Student student) async {
    final pageWidth = page.getClientSize().width;
    //final pageHeight = page.getClientSize().height;

    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 5);
    grid.columns[0].width = pageWidth * .1;
    grid.columns[1].width = pageWidth * .25;
    grid.columns[2].width = pageWidth * .350;
    grid.columns[3].width = pageWidth * .150;
    grid.columns[4].width = pageWidth * .150;

    // Add rows to the grid.
    //Cell Style
    PdfGridCellStyle cellTitleStyle =
        await PdfHelper.cellValueStyle(size: 10, isBold: true);

    PdfGridCellStyle cellTitleStyleCenter =
        await PdfHelper.cellValueStyle(size: 10, isBold: true, isCenter: true);

    PdfGridCellStyle cellValueStyle =
        await PdfHelper.cellValueStyle(size: 10, isBold: false);

    PdfGridCellStyle cellValueStyleCenter =
        await PdfHelper.cellValueStyle(size: 10, isBold: false, isCenter: true);

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = 'ADI SOYADI';
    row.cells[0].style = cellTitleStyle;
    row.cells[1].value = ': ${student.studentName ?? ''}';
    row.cells[1].style = cellValueStyle;
    row.cells[2].value = '';
    row.cells[2].style = cellValueStyle;
    row.cells[3].value =
        student.targetSchoolID != null ? 'HEDEFİM -  Puanı' : '';
    row.cells[3].style = cellTitleStyleCenter;
    row.cells[3].columnSpan = 2;

    // Add next row.
    row = grid.rows.add();
    row.cells[0].value = 'SINIFI';
    row.cells[0].style = cellTitleStyle;
    row.cells[1].value = ': ${student.className ?? ''}';
    row.cells[1].style = cellValueStyle;
    row.cells[2].value = '';
    row.cells[2].style = cellValueStyle;
    row.cells[3].value = student.targetSchoolID ?? '';
    row.cells[3].style = cellValueStyleCenter;
    row.cells[3].columnSpan = 2;

    // Add next row.
    row = grid.rows.add();
    row.cells[0].value = 'OKUL NO';
    row.cells[0].style = cellTitleStyle;
    row.cells[1].value = ': ${student.studentNumber ?? ''}';
    row.cells[1].style = cellValueStyle;
    row.cells[2].value = '';
    row.cells[2].style = cellValueStyle;
    row.cells[3].value = student.targetSchoolID != null ? 'Puanı' : '';
    row.cells[3].style = cellTitleStyleCenter;
    row.cells[4].value = student.targetSchoolID != null ? 'Yüzdelik D.:' : '';
    row.cells[4].style = cellTitleStyleCenter;

    // Set grid format.
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    // Draw table in the PDF page.
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            1, 41, page.getClientSize().width, page.getClientSize().height));
  }

  Future<void> _drawStudentProgram(
      PdfPage page, List<StudyProgram> programList) async {
    final PdfGrid grid = PdfGrid();
    int columnCount = 26;
    grid.columns.add(count: columnCount);

    // Add rows to the grid.
    //Cell Style
    PdfGridCellStyle cellTitleStyle = await PdfHelper.cellValueStyle(
        size: 8, isBold: true, isCenter: true, isBorder: true);

    /*
    PdfGridCellStyle cellValueStyle = await PdfHelper.cellValueStyle(
        size: 8, isBold: false, isCenter: true, isBorder: true);

     */

    final headers = grid.headers.add(2);
    PdfGridRow headerRow1 = headers[0];
    headerRow1.cells[0].value = '';
    headerRow1.cells[0].columnSpan = 2;
    headerRow1.cells[0].rowSpan = 2;
    headerRow1.cells[0].style = cellTitleStyle;

    headerRow1.cells[2].value = 'TÜRKÇE';
    headerRow1.cells[2].columnSpan = 4;
    headerRow1.cells[2].style = cellTitleStyle;

    headerRow1.cells[6].value = 'MATEMATİK';
    headerRow1.cells[6].columnSpan = 4;
    headerRow1.cells[6].style = cellTitleStyle;

    headerRow1.cells[10].value = 'FEN BİLİMLERİ';
    headerRow1.cells[10].columnSpan = 4;
    headerRow1.cells[10].style = cellTitleStyle;

    headerRow1.cells[14].value = 'İNKILAP TARİHİ';
    headerRow1.cells[14].columnSpan = 4;
    headerRow1.cells[14].style = cellTitleStyle;

    headerRow1.cells[18].value = 'İNGİLİZCE';
    headerRow1.cells[18].columnSpan = 4;
    headerRow1.cells[18].style = cellTitleStyle;

    headerRow1.cells[22].value = 'DİN KÜLTÜRÜ';
    headerRow1.cells[22].columnSpan = 4;
    headerRow1.cells[22].style = cellTitleStyle;

    PdfGridRow headerRow2 = headers[1];

    for (var j = 0; j < columnCount; j++) {
      if (j == 2 || j == 6 || j == 10 || j == 14 || j == 18 || j == 22) {
        headerRow2.cells[j].value = "Hed.";
      }

      if (j == 3 || j == 7 || j == 11 || j == 15 || j == 19 || j == 23) {
        headerRow2.cells[j].value = "Çöz.";
      }

      if (j == 4 || j == 8 || j == 12 || j == 16 || j == 20 || j == 24) {
        headerRow2.cells[j].value = "Doğ.";
      }

      if (j == 5 || j == 9 || j == 13 || j == 17 || j == 21 || j == 25) {
        headerRow2.cells[j].value = "Yan.";
      }

      headerRow2.cells[j].style = cellTitleStyle;
    }

    /*
    for (var i = 0; i <= rowCount; i++) {
      row = grid.rows.add();
      for (var j = 0; j < columnCount; j++) {
        if (j == 0) {
          row.cells[j].value = "12.10.2022";
          grid.columns[j].width = 60;
        } else if (j == 1) {
          row.cells[j].value = "Pazartesi";
          grid.columns[j].width = 60;
        } else {
          row.cells[j].value = "3";
        }

        row.cells[j].style = cellTitleStyle;
      }
    }
     */

    // Set first two column width
    grid.columns[0].width = 60;
    grid.columns[1].width = 60;

    PdfGridRow row;
    for (var studyProgram in programList) {
      row = grid.rows.add();
      for (var i = 0; i < columnCount; i++) {
        //set cell value
        await _setRowValues(
            row: row,
            index: i,
            studyProgram: studyProgram,
            style: cellTitleStyle);
      }
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    // Draw table in the PDF page.
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(10, 120, page.getClientSize().width - 10,
            page.getClientSize().height));
  }

  Future<void> _setRowValues({
    required PdfGridRow row,
    required int index,
    required StudyProgram studyProgram,
    required PdfGridCellStyle style,
  }) async {
    String value = "";
    switch (index) {
      case 0:
        value = studyProgram.date != null
            ? DateFormat("dd.MM.yyyy").format(studyProgram.date!)
            : 'Tarih';
        break;

      case 1:
        value = studyProgram.date != null
            ? DateFormat("EEEE", 'tr').format(studyProgram.date!)
            : 'Tarih';
        break;

      case 2:
        value = _checkNull(studyProgram.turTarget);
        break;
      case 3:
        value = _checkNull(studyProgram.turSolved);
        break;
      case 4:
        value = _checkNull(studyProgram.turCorrect);
        break;
      case 5:
        value = _checkNull(studyProgram.turIncorrect);
        break;

      case 6:
        value = _checkNull(studyProgram.matTarget);
        break;
      case 7:
        value = _checkNull(studyProgram.matSolved);
        break;
      case 8:
        value = _checkNull(studyProgram.matCorrect);
        break;
      case 9:
        value = _checkNull(studyProgram.matIncorrect);
        break;

      case 10:
        value = _checkNull(studyProgram.fenTarget);
        break;
      case 11:
        value = _checkNull(studyProgram.fenSolved);
        break;
      case 12:
        value = _checkNull(studyProgram.fenCorrect);
        break;
      case 13:
        value = _checkNull(studyProgram.fenIncorrect);
        break;

      case 14:
        value = _checkNull(studyProgram.inkTarget);
        break;
      case 15:
        value = _checkNull(studyProgram.inkSolved);
        break;
      case 16:
        value = _checkNull(studyProgram.inkCorrect);
        break;
      case 17:
        value = _checkNull(studyProgram.inkIncorrect);
        break;

      case 18:
        value = _checkNull(studyProgram.ingTarget);
        break;
      case 19:
        value = _checkNull(studyProgram.ingSolved);
        break;
      case 20:
        value = _checkNull(studyProgram.ingCorrect);
        break;
      case 21:
        value = _checkNull(studyProgram.ingIncorrect);
        break;

      case 22:
        value = _checkNull(studyProgram.dinTarget);
        break;
      case 23:
        value = _checkNull(studyProgram.dinSolved);
        break;
      case 24:
        value = _checkNull(studyProgram.dinCorrect);
        break;
      case 25:
        value = _checkNull(studyProgram.dinIncorrect);
        break;
    }

    row.cells[index].value = value;
    row.cells[index].style = style;
  }

  String _checkNull(int? data) {
    return data != null ? data.toString() : '';
  }

  Future<void> _drawStudentTimeTable(
      PdfPage page, Map<int, List<TimeTable>> timeTableMap) async {
    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 7);

    // Add rows to the grid.
    //Cell Style
    PdfGridCellStyle cellTitleStyle = await PdfHelper.cellValueStyle(
        size: 8, isBold: true, isCenter: true, isBorder: true);

    PdfGridCellStyle cellStyle = await PdfHelper.cellValueStyle(
        size: 8, isBold: false, isCenter: true, isBorder: false);

    _setHeaderRow(grid, cellTitleStyle);

    PdfGridRow row;

    timeTableMap.forEach((key, timeTableList) {
      row = grid.rows.add();
      row.height = 40;
      var i = 0;
      for (var timeTable in timeTableList) {
        PdfGrid innerGrid = _getInnerGrid(cellStyle, timeTable);
        row.cells[i].value = innerGrid;
        row.cells[i].style = cellTitleStyle;
        i++;
      }
    });

    // Draw table in the PDF page.
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(10, 300, page.getClientSize().width - 10,
            page.getClientSize().height));
  }

  void _setHeaderRow(PdfGrid grid, PdfGridCellStyle cellTitleStyle) {
    final headers = grid.headers.add(1);
    PdfGridRow headerRow1 = headers[0];
    headerRow1.cells[0].value = 'Pazartesi';
    headerRow1.cells[0].style = cellTitleStyle;

    headerRow1.cells[1].value = 'Salı';
    headerRow1.cells[1].style = cellTitleStyle;

    headerRow1.cells[2].value = 'Çarşamba';
    headerRow1.cells[2].style = cellTitleStyle;

    headerRow1.cells[3].value = 'Perşembe';
    headerRow1.cells[3].style = cellTitleStyle;

    headerRow1.cells[4].value = 'Cuma';
    headerRow1.cells[4].style = cellTitleStyle;

    headerRow1.cells[5].value = 'Cumartesi';
    headerRow1.cells[5].style = cellTitleStyle;

    headerRow1.cells[6].value = 'Pazar';
    headerRow1.cells[6].style = cellTitleStyle;
  }

  PdfGrid _getInnerGrid(PdfGridCellStyle cellStyle, TimeTable timeTable) {
    final PdfGrid innerGrid = PdfGrid();
    innerGrid.columns.add(count: 1);
    PdfGridRow innerRow = innerGrid.rows.add();
    innerRow.height = 12;
    innerRow.cells[0].value =
        _getTimeTableDay(timeTable.startTime, timeTable.endTime);
    innerRow.cells[0].style = cellStyle;

    innerRow = innerGrid.rows.add();
    innerRow.cells[0].value = _getLessonNameText(lessonID: timeTable.lessonID);
    innerRow.cells[0].style = cellStyle;

    innerRow = innerGrid.rows.add();
    innerRow.cells[0].value = _getSubjectName(
        lessonID: timeTable.lessonID, subjectID: timeTable.subjectID);
    innerRow.cells[0].style = cellStyle;

    innerGrid.style.cellPadding = PdfPaddings(left: 5, right: 5);

    return innerGrid;
  }

  String _getTimeTableDay(int? startTime, int? endTime) {
    if (startTime != null && endTime != null) {
      return "${Helper.getTimeDayText(startTime)} - ${Helper.getTimeDayText(endTime)}";
    } else {
      return "";
    }
  }

  String _getLessonNameText({String? lessonID}) {
    final _lessonList = _timeTableController.lessonWithSubjectList;
    if (lessonID != null) {
      LessonWithSubject? lessonWithSubject = _lessonList
          .firstWhereOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        return lessonWithSubject.lesson.lessonName!;
      }
    }
    return "";
  }

  String _getSubjectName(
      {required String? lessonID, required String? subjectID}) {
    final _lessonList = _timeTableController.lessonWithSubjectList;
    if (lessonID != null) {
      LessonWithSubject? lessonWithSubject = _lessonList
          .firstWhereOrNull((element) => element.lesson.id == lessonID);
      if (lessonWithSubject != null) {
        if (lessonWithSubject.subjectList != null) {
          Subject? subject = lessonWithSubject.subjectList!
              .firstWhereOrNull((subject) => subject.id == subjectID);
          if (subject != null) {
            return subject.subject!;
          }
        }
      }
    }
    return "";
  }
}
