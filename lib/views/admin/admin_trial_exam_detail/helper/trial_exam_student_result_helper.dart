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
      double turTotalNet = 0;
      double matTotalNet = 0;
      double fenTotalNet = 0;
      double sosTotalNet = 0;
      double ingTotalNet = 0;
      double dinTotalNet = 0;
      double totalPoint = 0;
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
        turTotalNet = turTotalNet + examResult.turNet!;
        matTotalNet = matTotalNet + examResult.matNet!;
        fenTotalNet = fenTotalNet + examResult.fenNet!;
        sosTotalNet = sosTotalNet + examResult.sosNet!;
        ingTotalNet = ingTotalNet + examResult.ingNet!;
        dinTotalNet = dinTotalNet + examResult.dinNet!;
        totalPoint = totalPoint + examResult.totalPoint!;
        totalNet = totalNet / _getTotalNet(examResult);

        i++;
      }

      final turAvg = double.parse((turTotalNet / i).toStringAsFixed(2));
      final matAvg = double.parse((matTotalNet / i).toStringAsFixed(2));
      final fenAvg = double.parse((fenTotalNet / i).toStringAsFixed(2));
      final sosAvg = double.parse((sosTotalNet / i).toStringAsFixed(2));
      final dinAvg = double.parse((dinTotalNet / i).toStringAsFixed(2));
      final ingAvg = double.parse((ingTotalNet / i).toStringAsFixed(2));
      final totalPointAvg = double.parse((totalPoint / i).toStringAsFixed(3));
      final totAvg = turAvg + matAvg + fenAvg + sosAvg + dinAvg + ingAvg;

      studentResult.turAvg = turAvg;
      studentResult.matAvg = matAvg;
      studentResult.fenAvg = fenAvg;
      studentResult.sosAvg = sosAvg;
      studentResult.dinAvg = dinAvg;
      studentResult.ingAvg = ingAvg;
      studentResult.totalPointAvg = totalPointAvg;
      studentResult.totAvg = totAvg;

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

  double _getTotalNet(TrialExamResult examResult) =>
      examResult.turNet! +
      examResult.sosNet! +
      examResult.ingNet! +
      examResult.dinNet! +
      examResult.fenNet! +
      examResult.matNet!;
}
