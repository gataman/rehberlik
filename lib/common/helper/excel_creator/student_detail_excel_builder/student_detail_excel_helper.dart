import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../models/question_follow.dart';

class StudentDetailExcelHelper {
  Style pageTitleStyle(Style style) {
    style.fontName = 'Alegreya Sans SC Black';
    style.backColor = '#EFEFEF';
    style.fontSize = 36;
    style.bold = true;
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;
    // style.borders.all.color = '#000000';
    // style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  void setStyle({
    required Style style,
    bool isBold = false,
    double fontSize = 18,
    String fontName = 'Calibri',
    VAlignType vAlign = VAlignType.center,
    HAlignType hAlign = HAlignType.center,
  }) {
    style.fontName = fontName;
    style.fontSize = fontSize;
    style.bold = isBold;
    style.vAlign = vAlign;
    style.hAlign = hAlign;
  }

  void setBorderAll({required Style style, LineStyle lineStyle = LineStyle.thin, String color = '#000000'}) {
    style.borders.all.color = color;
    style.borders.all.lineStyle = lineStyle;
  }

  void setColors({required Style style, String backColor = '#EFEFEF'}) {
    style.backColor = backColor;
    //style.fontColor =
  }

  Style mediumTextStyle(Style style) {
    style.fontName = 'Calibri';
    style.fontSize = 18;
    style.vAlign = VAlignType.bottom;
    return style;
  }

  Style subTitleStyle(Workbook workbook) {
    final Style style = workbook.styles.add('SubTitleStyle');
    style.fontName = 'Calibri';
    style.fontSize = 18;
    style.bold = true;
    style.vAlign = VAlignType.bottom;
    return style;
  }

  Style smallTextStyle(Workbook workbook) {
    final Style style = workbook.styles.add('SmallTextStyle');
    style.fontName = 'Calibri';
    style.backColor = '#EFEFEF';
    style.fontSize = 11;
    style.bold = false;
    style.vAlign = VAlignType.center;
    style.hAlign = HAlignType.center;
    style.borders.all.color = '#000000';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  Style averageSubTitleStyle(Workbook workbook) {
    final Style style = workbook.styles.add('AverageSubTitleStyle');
    style.fontName = 'Calibri';
    style.fontSize = 11;
    style.vAlign = VAlignType.center;
    style.hAlign = HAlignType.center;
    style.borders.all.color = '#000000';
    style.borders.all.lineStyle = LineStyle.thin;
    return style;
  }

  String getQuestionFollowText({required int column, required QuestionFollow questionFollow}) {
    String value = "";
    switch (column) {
      case 1:
        value = questionFollow.date != null ? DateFormat("dd.MM.yyyy").format(questionFollow.date!) : 'Tarih';
        break;

      case 2:
        value = questionFollow.date != null ? DateFormat("EEEE", 'tr').format(questionFollow.date!) : 'Tarih';
        break;
    }

    return value;
  }

  int? getQuestionFollowNumber({required int column, required QuestionFollow questionFollow}) {
    int? value;
    switch (column) {
      case 3:
        value = questionFollow.turTarget;
        break;
      case 4:
        value = questionFollow.turSolved;
        break;
      case 5:
        value = questionFollow.turCorrect;
        break;
      case 6:
        value = questionFollow.turIncorrect;
        break;

      case 7:
        value = questionFollow.matTarget;
        break;
      case 8:
        value = questionFollow.matSolved;
        break;
      case 9:
        value = questionFollow.matCorrect;
        break;
      case 10:
        value = questionFollow.matIncorrect;
        break;

      case 11:
        value = questionFollow.fenTarget;
        break;
      case 12:
        value = questionFollow.fenSolved;
        break;
      case 13:
        value = questionFollow.fenCorrect;
        break;
      case 14:
        value = questionFollow.fenIncorrect;
        break;

      case 15:
        value = questionFollow.inkTarget;
        break;
      case 16:
        value = questionFollow.inkSolved;
        break;
      case 17:
        value = questionFollow.inkCorrect;
        break;
      case 18:
        value = questionFollow.inkIncorrect;
        break;

      case 19:
        value = questionFollow.ingTarget;
        break;
      case 20:
        value = questionFollow.ingSolved;
        break;
      case 21:
        value = questionFollow.ingCorrect;
        break;
      case 22:
        value = questionFollow.ingIncorrect;
        break;

      case 23:
        value = questionFollow.dinTarget;
        break;
      case 24:
        value = questionFollow.dinSolved;
        break;
      case 25:
        value = questionFollow.dinCorrect;
        break;
      case 26:
        value = questionFollow.dinIncorrect;
        break;
    }

    return value;
  }

  Map<int, int> getQuestionFollowTotalCount(List<QuestionFollow> questionFollowList) {
    int turHedCount = 0;
    int turCozCount = 0;
    int turDogCount = 0;
    int turYanCount = 0;
    int matHedCount = 0;
    int matCozCount = 0;
    int matDogCount = 0;
    int matYanCount = 0;
    int fenHedCount = 0;
    int fenCozCount = 0;
    int fenDogCount = 0;
    int fenYanCount = 0;
    int inkHedCount = 0;
    int inkCozCount = 0;
    int inkDogCount = 0;
    int inkYanCount = 0;
    int dinHedCount = 0;
    int dinCozCount = 0;
    int dinDogCount = 0;
    int dinYanCount = 0;
    int ingHedCount = 0;
    int ingCozCount = 0;
    int ingDogCount = 0;
    int ingYanCount = 0;

    for (var qf in questionFollowList) {
      turHedCount = turHedCount + (qf.turTarget ?? 0);
      turCozCount = turCozCount + (qf.turSolved ?? 0);
      turDogCount = turDogCount + (qf.turCorrect ?? 0);
      turYanCount = turYanCount + (qf.turIncorrect ?? 0);

      matHedCount = matHedCount + (qf.matTarget ?? 0);
      matCozCount = matCozCount + (qf.matSolved ?? 0);
      matDogCount = matDogCount + (qf.matCorrect ?? 0);
      matYanCount = matYanCount + (qf.matIncorrect ?? 0);

      fenHedCount = fenHedCount + (qf.fenTarget ?? 0);
      fenCozCount = fenCozCount + (qf.fenSolved ?? 0);
      fenDogCount = fenDogCount + (qf.fenCorrect ?? 0);
      fenYanCount = fenYanCount + (qf.fenIncorrect ?? 0);

      inkHedCount = inkHedCount + (qf.inkTarget ?? 0);
      inkCozCount = inkCozCount + (qf.inkSolved ?? 0);
      inkDogCount = inkDogCount + (qf.inkCorrect ?? 0);
      inkYanCount = inkYanCount + (qf.inkIncorrect ?? 0);

      dinHedCount = dinHedCount + (qf.dinTarget ?? 0);
      dinCozCount = dinCozCount + (qf.dinSolved ?? 0);
      dinDogCount = dinDogCount + (qf.dinCorrect ?? 0);
      dinYanCount = dinYanCount + (qf.dinIncorrect ?? 0);

      ingHedCount = ingHedCount + (qf.ingTarget ?? 0);
      ingCozCount = ingCozCount + (qf.ingSolved ?? 0);
      ingDogCount = ingDogCount + (qf.ingCorrect ?? 0);
      ingYanCount = ingYanCount + (qf.ingIncorrect ?? 0);
    }

    Map<int, int> questionFollowMap = {
      0: turHedCount,
      1: turCozCount,
      2: turDogCount,
      3: turYanCount,
      4: matHedCount,
      5: matCozCount,
      6: matDogCount,
      7: matYanCount,
      8: fenHedCount,
      9: fenCozCount,
      10: fenDogCount,
      11: fenYanCount,
      12: inkHedCount,
      13: inkCozCount,
      14: inkDogCount,
      15: inkYanCount,
      16: ingHedCount,
      17: ingCozCount,
      18: ingDogCount,
      19: ingYanCount,
      20: dinHedCount,
      21: dinCozCount,
      22: dinDogCount,
      23: dinYanCount
    };

    return questionFollowMap;
  }

  String getTimeTableCell({required int day, required int row}) {
    switch (day) {
      case 1:
        return 'A$row:B$row';
      case 2:
        return 'C$row:F$row';
      case 3:
        return 'G$row:J$row';
      case 4:
        return 'K$row:N$row';
      case 5:
        return 'O$row:R$row';
      case 6:
        return 'S$row:V$row';
      case 7:
        return 'W$row:Z$row';
      default:
        return 'A1';
    }
  }
}
