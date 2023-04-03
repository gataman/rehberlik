import '../../../../common/extensions.dart';
import '../../../../models/trial_exam_class_result.dart';
import '../../../../models/trial_exam_result.dart';

import '../../../../models/lesson.dart';

class TrialExamDetailHelper {
  final TrialExamResult studentExamResult;
  final List<TrialExamClassResult> classesExamResultList;

  late TrialExamClassResult _classAverages;
  late Map<String, double> _schoolAverages;
  late Map<String, int> _emptyCounts;

  TrialExamDetailHelper({required this.studentExamResult, required this.classesExamResultList}) {
    _classAverages = _getClassAverages();
    _schoolAverages = _getSchoolAverages();
    _emptyCounts = studentExamResult.getAllEmpty();
  }

  Map<String, dynamic> getStudentExamResultMap() {
    Map<String, dynamic> map = {
      'Türkçe': _getData(LessonCode.tur),
      'Matematik': _getData(LessonCode.mat),
      'Fen Bilimleri': _getData(LessonCode.fen),
      'Sosyal Bilgiler': _getData(LessonCode.sos),
      'Din': _getData(LessonCode.din),
      'İngilizce': _getData(LessonCode.ing),
    };
    return map;
  }

  Map<String, num?> _getData(LessonCode lessonCode) {
    switch (lessonCode) {
      case LessonCode.tur:
        return {
          'dog': studentExamResult.turDog,
          'yan': studentExamResult.turYan,
          'net': studentExamResult.turNet,
          'bos': _emptyCounts['tur'],
          'sinif': _classAverages.turAvg,
          'okul': _schoolAverages['tur']
        };

      case LessonCode.mat:
        return {
          'dog': studentExamResult.matDog,
          'yan': studentExamResult.matYan,
          'net': studentExamResult.matNet,
          'bos': _emptyCounts['mat'],
          'sinif': _classAverages.matAvg,
          'okul': _schoolAverages['mat']
        };

      case LessonCode.fen:
        return {
          'dog': studentExamResult.fenDog,
          'yan': studentExamResult.fenYan,
          'net': studentExamResult.fenNet,
          'bos': _emptyCounts['fen'],
          'sinif': _classAverages.fenAvg,
          'okul': _schoolAverages['fen']
        };

      case LessonCode.sos:
        return {
          'dog': studentExamResult.sosDog,
          'yan': studentExamResult.sosYan,
          'net': studentExamResult.sosNet,
          'bos': _emptyCounts['sos'],
          'sinif': _classAverages.sosAvg,
          'okul': _schoolAverages['sos']
        };

      case LessonCode.din:
        return {
          'dog': studentExamResult.dinDog,
          'yan': studentExamResult.dinYan,
          'net': studentExamResult.dinNet,
          'bos': _emptyCounts['din'],
          'sinif': _classAverages.dinAvg,
          'okul': _schoolAverages['din']
        };

      case LessonCode.ing:
        return {
          'dog': studentExamResult.ingDog,
          'yan': studentExamResult.ingYan,
          'net': studentExamResult.ingNet,
          'bos': _emptyCounts['ing'],
          'sinif': _classAverages.ingAvg,
          'okul': _schoolAverages['ing']
        };
      default:
        return {};
    }
  }

  Map<String, num?> getTotalCount() {
    return {
      'dog': studentExamResult.getTotalDog,
      'yan': studentExamResult.getTotalYan,
      'net': studentExamResult.getTotalNet,
      'bos': studentExamResult.getTotalEmptyCount,
      'sinif': _classAverages.totAvg,
      'okul': _schoolAverages['tot']
    };
  }

  Map<String, double> _getSchoolAverages() {
    final filteredList =
        classesExamResultList.where((element) => element.trialExamID == studentExamResult.examID).toList();
    double schoolTurTot = 0;
    double schoolMatTot = 0;
    double schoolFenTot = 0;
    double schoolSosTot = 0;
    double schoolIngTot = 0;
    double schoolDinTot = 0;
    int count = 0;

    for (var examResult in filteredList) {
      schoolTurTot = schoolTurTot + examResult.turAvg;
      schoolMatTot = schoolMatTot + examResult.matAvg;
      schoolFenTot = schoolFenTot + examResult.fenAvg;
      schoolSosTot = schoolSosTot + examResult.sosAvg;
      schoolIngTot = schoolIngTot + examResult.ingAvg;
      schoolDinTot = schoolDinTot + examResult.dinAvg;
      count++;
    }

    Map<String, double> schoolAvgMap = {
      'tur': (schoolTurTot / count),
      'mat': (schoolMatTot / count),
      'fen': (schoolFenTot / count),
      'sos': (schoolSosTot / count),
      'ing': (schoolIngTot / count),
      'din': (schoolDinTot / count),
      'tot': (schoolTurTot + schoolMatTot + schoolFenTot + schoolSosTot + schoolIngTot + schoolDinTot) / count
    };

    return schoolAvgMap;
  }

  TrialExamClassResult _getClassAverages() {
    final classAverages = classesExamResultList.findOrNull((element) =>
        element.classID.contains(studentExamResult.classID) && element.trialExamID.contains(studentExamResult.examID!));
    return classAverages!;
  }
}
