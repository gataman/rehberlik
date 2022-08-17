import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_imports.dart';

class PdfHelper {
  static Future<PdfFont> getPdfFont(
      {required double size, required bool isBold}) async {
    var path = 'fonts/roboto_bold.ttf';
    if (kIsWeb) {
      if (isBold) {
        path = 'fonts/roboto_bold.ttf';
      } else {
        path = 'fonts/roboto_regular.ttf';
      }
    } else {
      if (isBold) {
        path = 'assets/fonts/roboto_bold.ttf';
      } else {
        path = 'assets/fonts/roboto_regular.ttf';
      }
    }
    final ByteData fontData = await rootBundle.load(path);
    // final ttf = pw.Font.ttf(fontData);
    final dataint = fontData.buffer
        .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    final PdfFont font = PdfTrueTypeFont(dataint, size);
    return font;
  }

  static Future<PdfGridCellStyle> cellValueStyle({
    required double size,
    required bool isBold,
    bool? isCenter,
    bool? isBorder,
  }) async {
    PdfGridCellStyle cellValueStyle = PdfGridCellStyle();

    if (isBorder == null || !isBorder) {
      cellValueStyle.borders.all = PdfPens.transparent;
    } else {
      cellValueStyle.borders.all = PdfPen(PdfColor(91, 126, 215), width: .5);
    }

    cellValueStyle.font = await getPdfFont(size: size, isBold: isBold);

    if (isCenter != null && isCenter) {
      cellValueStyle.stringFormat =
          PdfStringFormat(alignment: PdfTextAlignment.center);
    }
    return cellValueStyle;
  }
}
