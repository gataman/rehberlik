import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfHelper {
  static Future<PdfFont> getPdfFont({required double size, required bool isBold}) async {
    var path = 'assets/fonts/roboto_bold.ttf';
    if (isBold) {
      path = 'assets/fonts/roboto_bold.ttf';
    } else {
      path = 'assets/fonts/roboto_regular.ttf';
    }
    final ByteData fontData = await rootBundle.load(path);
    // final ttf = pw.Font.ttf(fontData);
    final dataint = fontData.buffer.asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
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
      cellValueStyle.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
    }
    return cellValueStyle;
  }
}
