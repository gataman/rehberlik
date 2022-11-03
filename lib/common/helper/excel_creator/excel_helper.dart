import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelHelper {
  static Style studentInfoStyle(Workbook workbook) {
    final Style style = workbook.styles.add('StudentInfo');
    style.fontColor = '#1F4E78';
    style.fontSize = 12;
    style.bold = true;
    style.hAlign = HAlignType.left;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#1F4E78';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style titleLargeStyle({required Workbook workbook}) {
    final Style style = workbook.styles.add('TitleLargeStyle');
    style.fontColor = '#000000';
    style.fontSize = 16;
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#1F4E78';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style titleMediumStyle({required Workbook workbook}) {
    final Style style = workbook.styles.add('TitleMediumStyle');
    style.fontColor = '#000000';
    style.fontSize = 12;
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#1F4E78';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style averageTitleStyle({required Workbook workbook}) {
    final Style style = workbook.styles.add('TitleSmallStyle');
    style.fontColor = '#000000';
    style.fontSize = 10;
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#A9D08E';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style averageValueStyle({required Workbook workbook}) {
    final Style style = workbook.styles.add('AverageValueStyle');
    style.fontColor = '#375623';
    style.fontSize = 12;
    style.backColor = '#E2EFDA';
    style.bold = true;
    style.hAlign = HAlignType.left;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#A9D08E';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style examResultTitle({required Workbook workbook}) {
    final Style style = workbook.styles.add('ExamResultTitle');
    style.fontColor = '#FFFFFF';
    style.fontSize = 12;
    style.backColor = '#1F4E78';
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#9BC2E6';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style examResultValue1({required Workbook workbook}) {
    final Style style = workbook.styles.add('ExamResultValue1');
    //style.fontColor = '#FFFFFF';
    style.fontSize = 11;
    style.backColor = '#BDD7EE';
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#2F75B5';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  static Style examResultValue2({required Workbook workbook}) {
    final Style style = workbook.styles.add('ExamResultValue2');
    //style.fontColor = '#FFFFFF';
    style.fontSize = 11;
    style.backColor = '#DDEBF7';
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    style.borders.all.color = '#2F75B5';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }
}
