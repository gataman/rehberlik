import 'package:rehberlik/common/extensions.dart';

import '../../../../models/trial_exam_result.dart';
import '../../../../models/trial_exam_student_result.dart';

class TrialExamStudentResultHelper {
  List<TrialExamStudentResult> createTrialExamStudentResultList(
      {required List<TrialExamResult> trialExamAllResultList, required int classLevel}) {
    final List<TrialExamStudentResult> trialExamStudentResultList = [];
    final groupedList = trialExamAllResultList.groupBy((examResult) => examResult.studentID);

    groupedList.forEach((studentID, examResultList) {
      int i = 0;
      double turTotalDog = 0;
      double turTotalYan = 0;
      double turTotalNet = 0;
      double matTotalDog = 0;
      double matTotalYan = 0;
      double matTotalNet = 0;
      double fenTotalDog = 0;
      double fenTotalYan = 0;
      double fenTotalNet = 0;
      double sosTotalDog = 0;
      double sosTotalYan = 0;
      double sosTotalNet = 0;
      double ingTotalDog = 0;
      double ingTotalYan = 0;
      double ingTotalNet = 0;
      double dinTotalDog = 0;
      double dinTotalYan = 0;
      double dinTotalNet = 0;
      double totalPoint = 0;
      double totalDog = 0;
      double totalYan = 0;
      double totalNet = 0;
      TrialExamStudentResult studentResult = TrialExamStudentResult(studentID: studentID);

      for (var examResult in examResultList) {
        if (i == 0) {
          studentResult.studentName = examResult.studentName;
          studentResult.studentNumber = examResult.studentNumber;
          studentResult.classID = examResult.classID;
          studentResult.className = examResult.className;
          studentResult.classLevel = classLevel;
        }
        turTotalDog = turTotalDog + examResult.turDog!;
        turTotalYan = turTotalYan + examResult.turYan!;
        turTotalNet = turTotalNet + examResult.turNet!;
        matTotalDog = matTotalDog + examResult.matDog!;
        matTotalYan = matTotalYan + examResult.matYan!;
        matTotalNet = matTotalNet + examResult.matNet!;
        fenTotalDog = fenTotalDog + examResult.fenDog!;
        fenTotalYan = fenTotalYan + examResult.fenYan!;
        fenTotalNet = fenTotalNet + examResult.fenNet!;
        sosTotalDog = sosTotalDog + examResult.sosDog!;
        sosTotalYan = sosTotalYan + examResult.sosYan!;
        sosTotalNet = sosTotalNet + examResult.sosNet!;
        ingTotalDog = ingTotalDog + examResult.ingDog!;
        ingTotalYan = ingTotalYan + examResult.ingYan!;
        ingTotalNet = ingTotalNet + examResult.ingNet!;
        dinTotalDog = dinTotalDog + examResult.dinDog!;
        dinTotalYan = dinTotalYan + examResult.dinYan!;
        dinTotalNet = dinTotalNet + examResult.dinNet!;
        totalPoint = totalPoint + examResult.totalPoint!;
        totalDog = totalDog + _getTotalDog(examResult);
        totalYan = totalYan + _getTotalYan(examResult);
        totalNet = totalNet / _getTotalNet(examResult);

        i++;
      }

      final turDogAvg = double.parse((turTotalDog / i).toStringAsFixed(2));
      final turYanAvg = double.parse((turTotalYan / i).toStringAsFixed(2));
      final turNetAvg = double.parse((turTotalNet / i).toStringAsFixed(2));
      final matDogAvg = double.parse((matTotalDog / i).toStringAsFixed(2));
      final matYanAvg = double.parse((matTotalYan / i).toStringAsFixed(2));
      final matNetAvg = double.parse((matTotalNet / i).toStringAsFixed(2));
      final fenDogAvg = double.parse((fenTotalDog / i).toStringAsFixed(2));
      final fenYanAvg = double.parse((fenTotalYan / i).toStringAsFixed(2));
      final fenNetAvg = double.parse((fenTotalNet / i).toStringAsFixed(2));
      final sosDogAvg = double.parse((sosTotalDog / i).toStringAsFixed(2));
      final sosYanAvg = double.parse((sosTotalYan / i).toStringAsFixed(2));
      final sosNetAvg = double.parse((sosTotalNet / i).toStringAsFixed(2));
      final dinDogAvg = double.parse((dinTotalDog / i).toStringAsFixed(2));
      final dinYanAvg = double.parse((dinTotalYan / i).toStringAsFixed(2));
      final dinNetAvg = double.parse((dinTotalNet / i).toStringAsFixed(2));
      final ingDogAvg = double.parse((ingTotalDog / i).toStringAsFixed(2));
      final ingYanAvg = double.parse((ingTotalYan / i).toStringAsFixed(2));
      final ingNetAvg = double.parse((ingTotalNet / i).toStringAsFixed(2));
      final totalPointAvg = double.parse((totalPoint / i).toStringAsFixed(3));
      final totDogAvg = double.parse((totalDog / i).toStringAsFixed(2));
      final totYanAvg = double.parse((totalYan / i).toStringAsFixed(2));
      final totAvg = turNetAvg + matNetAvg + fenNetAvg + sosNetAvg + dinNetAvg + ingNetAvg;

      studentResult.turDogAvg = turDogAvg;
      studentResult.turYanAvg = turYanAvg;
      studentResult.turNetAvg = turNetAvg;
      studentResult.matDogAvg = matDogAvg;
      studentResult.matYanAvg = matYanAvg;
      studentResult.matNetAvg = matNetAvg;
      studentResult.fenDogAvg = fenDogAvg;
      studentResult.fenYanAvg = fenYanAvg;
      studentResult.fenNetAvg = fenNetAvg;
      studentResult.sosDogAvg = sosDogAvg;
      studentResult.sosYanAvg = sosYanAvg;
      studentResult.sosNetAvg = sosNetAvg;
      studentResult.dinDogAvg = dinDogAvg;
      studentResult.dinYanAvg = dinYanAvg;
      studentResult.dinNetAvg = dinNetAvg;
      studentResult.ingDogAvg = ingDogAvg;
      studentResult.ingYanAvg = ingYanAvg;
      studentResult.ingNetAvg = ingNetAvg;
      studentResult.totalPointAvg = totalPointAvg;
      studentResult.totDogAvg = totDogAvg;
      studentResult.totYanAvg = totYanAvg;
      studentResult.totNetAvg = totAvg;

      trialExamStudentResultList.add(studentResult);
    });

    trialExamStudentResultList.sort((a, b) => b.totalPointAvg.compareTo(a.totalPointAvg));
    _calculateSchoolRank(trialExamStudentResultList);
    _calculateClassRank(trialExamStudentResultList);

    return trialExamStudentResultList;
  }

  void _calculateClassRank(List<TrialExamStudentResult> trialExamStudentResultList) {
    final classList = trialExamStudentResultList.groupBy((result) => result.className);
    classList.forEach((className, resultList) {
      int classRank = 1;
      for (var result in resultList) {
        result.classRank = classRank;
        classRank++;
      }
    });
  }

  void _calculateSchoolRank(List<TrialExamStudentResult> trialExamStudentResultList) {
    int schoolRank = 1;
    for (var result in trialExamStudentResultList) {
      result.schoolRank = schoolRank;
      schoolRank++;
    }
  }

  int _getTotalDog(TrialExamResult examResult) =>
      examResult.turDog! +
      examResult.sosDog! +
      examResult.ingDog! +
      examResult.dinDog! +
      examResult.fenDog! +
      examResult.matDog!;

  int _getTotalYan(TrialExamResult examResult) =>
      examResult.turYan! +
      examResult.sosYan! +
      examResult.ingYan! +
      examResult.dinYan! +
      examResult.fenYan! +
      examResult.matYan!;

  double _getTotalNet(TrialExamResult examResult) =>
      examResult.turNet! +
      examResult.sosNet! +
      examResult.ingNet! +
      examResult.dinNet! +
      examResult.fenNet! +
      examResult.matNet!;
}
