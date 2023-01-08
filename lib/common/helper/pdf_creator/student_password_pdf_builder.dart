import '../../../models/student_with_class.dart';
import 'pdf_helper.dart';
import '../save_file_mobile.dart' if (dart.library.html) 'package:rehberlik/common/helper/save_file_web.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_imports.dart';

class StudentPasswordPdfBuilder {
  final ValueNotifier<bool> notifier = ValueNotifier(false);
  final BuildContext context;

  StudentPasswordPdfBuilder(this.context);

  Future<void> build(List<StudentWithClass> classesList) async {
    final PdfDocument pdfDocument = PdfDocument();

    //pdfDocument.pageSettings.orientation = PdfPageOrientation.landscape;

    // final List<Student> studentList = [];

    // for (var studentWithClasses in classesList) {
    //   //await _drawHeader(page, pageSize, studentWithClasses);
    //   studentList.addAll(studentWithClasses.studentList!);
    // }

    //final List<Student> studentList = [];

    for (var studentWithClasses in classesList) {
      final PdfPage page = pdfDocument.pages.add();
      final Size pageSize = page.getClientSize();
      await _drawHeader(page, pageSize, studentWithClasses);
      await _drawClassBox(page, studentWithClasses.studentList!);
      //studentList.addAll(studentWithClasses.studentList!);
    }

    final List<int> bytes = await pdfDocument.save();
    pdfDocument.dispose();
    await FileSaveHelper.saveAndLaunchFile(bytes, 'sifreler.pdf');
    notifier.value = false;
  }

  Future<void> _drawHeader(PdfPage page, Size pageSize, StudentWithClass studentWithClasses) async {
    page.graphics.drawRectangle(brush: PdfBrushes.white, bounds: Rect.fromLTWH(0, 0, pageSize.width, 30));
    //Draw string
    page.graphics.drawString(studentWithClasses.classes.className!, await PdfHelper.getPdfFont(size: 14, isBold: true),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 25),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle, alignment: PdfTextAlignment.center));
  }

  Future<void> _drawClassBox(PdfPage page, List<Student> studentList) async {
    final pageWidth = page.getClientSize().width;
    //final pageHeight = page.getClientSize().height;

    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 3);
    grid.columns[0].width = pageWidth * .34;
    grid.columns[1].width = pageWidth * .33;
    grid.columns[2].width = pageWidth * .33;

    // Add rows to the grid.
    //Cell Style
    PdfGridCellStyle nameStyle = await PdfHelper.cellValueStyle(size: 12, isBold: true, isCenter: true);

    PdfGridCellStyle titleStyle = await PdfHelper.cellValueStyle(size: 12, isBold: false, isCenter: false);

    PdfGridCellStyle passwordStyle = await PdfHelper.cellValueStyle(size: 12, isBold: false, isCenter: false);

    PdfGridRow row = grid.rows.add();
    var index = 0;

    for (var i = 0; i < studentList.length; i++) {
      if (i == 0) {
        row.cells[0].value = await _getStudentsInfo(studentList[0], nameStyle, titleStyle, passwordStyle);
        row.cells[1].value = await _getStudentsInfo(studentList[1], nameStyle, titleStyle, passwordStyle);
        row.cells[2].value = await _getStudentsInfo(studentList[2], nameStyle, titleStyle, passwordStyle);
        //row.cells[1].style = cellValueStyleCenter;
      }

      if (i != 0 && i % 3 == 0) {
        index = 0;
        row = grid.rows.add();
      }

      row.cells[index].value = await _getStudentsInfo(studentList[i], nameStyle, titleStyle, passwordStyle);
      //row.cells[index].style = cellValueStyleCenter;

      index++;
    }

    // Set grid format.
    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    // Draw table in the PDF page.
    grid.draw(page: page, bounds: Rect.fromLTWH(0, 25, page.getClientSize().width, page.getClientSize().height));
  }

  Future<PdfGrid> _getStudentsInfo(
      Student student, PdfGridCellStyle nameStyle, PdfGridCellStyle numberStyle, PdfGridCellStyle passwordStyle) async {
    final PdfGrid studentGrid = PdfGrid();
    studentGrid.columns.add(count: 1);
    //grid.columns[0].width = pageWidth * .5;

    PdfGridRow row = studentGrid.rows.add();
    row.height = 20;
    //row.cells[0].value = '(${student.className}) ${student.studentName}';
    row.cells[0].value = student.studentName;
    row.cells[0].style = nameStyle;

    row = studentGrid.rows.add();
    row.height = 20;
    row.cells[0].value = 'Öğrenci No: ${student.studentNumber}';
    row.cells[0].style = numberStyle;

    row = studentGrid.rows.add();
    row.height = 20;
    row.cells[0].value = 'Şifresi: ${student.password}';
    row.cells[0].style = passwordStyle;

    // Set grid format.
    //studentGrid.style.cellPadding = PdfPaddings(left: 5, top: 5);

    return studentGrid;
    // Draw table in the PDF page.
  }
}
