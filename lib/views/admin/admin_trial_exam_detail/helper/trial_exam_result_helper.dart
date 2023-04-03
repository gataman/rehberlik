import 'package:flutter_excel/excel.dart';
import '../../../../common/extensions.dart';
import '../../../../models/trial_exam.dart';
import '../../../../models/trial_exam_class_result.dart';

import '../../../../common/helper/trial_exam_graph/trial_exam_graph.dart';
import '../../../../models/helpers/lgs_factors.dart';
import '../../../../models/helpers/student_nets.dart';
import '../../../../models/student.dart';
import '../../../../models/trial_exam_result.dart';

class TrialExamResultHelper {
  List<TrialExamGraph> getTrialExamGraphList({required List<TrialExamClassResult> trialExamClassResultList}) {
    List<TrialExamGraph> trialExamGraphList = [];
    trialExamClassResultList.sort((a, b) => a.className.compareTo(b.className));

    final turGraph = TrialExamGraph(graphLabelName: 'Türkçe', lessonType: LessonType.twenty);
    final matGraph = TrialExamGraph(graphLabelName: 'Matematik', lessonType: LessonType.twenty);
    final fenGraph = TrialExamGraph(graphLabelName: 'Fen Bilimleri', lessonType: LessonType.twenty);
    final sosGraph = TrialExamGraph(graphLabelName: 'Sosyal Bilgiler', lessonType: LessonType.ten);
    final ingGraph = TrialExamGraph(graphLabelName: 'İngilizce', lessonType: LessonType.ten);
    final dinGraph = TrialExamGraph(graphLabelName: 'Din Kültürü', lessonType: LessonType.ten);

    for (var result in trialExamClassResultList) {
      turGraph.itemList.add(TrialExamGraphItem(itemName: result.className, value: result.turAvg));
      fenGraph.itemList.add(TrialExamGraphItem(itemName: result.className, value: result.fenAvg));
      matGraph.itemList.add(TrialExamGraphItem(itemName: result.className, value: result.matAvg));
      sosGraph.itemList.add(TrialExamGraphItem(itemName: result.className, value: result.sosAvg));
      ingGraph.itemList.add(TrialExamGraphItem(itemName: result.className, value: result.ingAvg));
      dinGraph.itemList.add(TrialExamGraphItem(itemName: result.className, value: result.dinAvg));
    }

    trialExamGraphList.add(turGraph);
    trialExamGraphList.add(matGraph);
    trialExamGraphList.add(fenGraph);
    trialExamGraphList.add(sosGraph);
    trialExamGraphList.add(ingGraph);
    trialExamGraphList.add(dinGraph);

    return trialExamGraphList;
  }

  List<TrialExamClassResult> getTrialExamClassResultList(
      {required List<TrialExamResult>? trialExamResultList, required TrialExam trialExam}) {
    List<TrialExamClassResult> trialExamClassResultList = [];

    if (trialExamResultList != null) {
      final groupedList = trialExamResultList.groupBy((trialExamResult) => trialExamResult.className);
      String classID = '';
      groupedList.forEach((className, list) {
        double turTotalNet = 0;
        double matTotalNet = 0;
        double fenTotalNet = 0;
        double sosTotalNet = 0;
        double ingTotalNet = 0;
        double dinTotalNet = 0;
        double totalPoint = 0;
        var i = 0;

        for (var trialExamResult in list) {
          turTotalNet = turTotalNet + trialExamResult.turNet!;
          matTotalNet = matTotalNet + trialExamResult.matNet!;
          fenTotalNet = fenTotalNet + trialExamResult.fenNet!;
          sosTotalNet = sosTotalNet + trialExamResult.sosNet!;
          ingTotalNet = ingTotalNet + trialExamResult.ingNet!;
          dinTotalNet = dinTotalNet + trialExamResult.dinNet!;
          totalPoint = totalPoint + trialExamResult.totalPoint!;
          if (i == 0) {
            classID = trialExamResult.classID;
          }
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

        final trialExamClassResult = TrialExamClassResult(
            classID: classID,
            className: className,
            classLevel: trialExam.classLevel!,
            trialExamID: trialExam.id!,
            trialExamName: trialExam.examName!,
            trialExamCode: trialExam.examCode!,
            turAvg: turAvg,
            sosAvg: sosAvg,
            dinAvg: dinAvg,
            ingAvg: ingAvg,
            matAvg: matAvg,
            fenAvg: fenAvg,
            totAvg: totAvg,
            totPointAvg: totalPointAvg);

        trialExamClassResultList.add(trialExamClassResult);
      });
    }

    return trialExamClassResultList;
  }

  TrialExamResult buildTrialExamResult(List<Data?> row, Student student, TrialExam trialExam) {
    final turNet = getNet(row[2], row[3]);
    final sosNet = getNet(row[4], row[5]);
    final dinNet = getNet(row[6], row[7]);
    final ingNet = getNet(row[8], row[9]);
    final matNet = getNet(row[10], row[11]);
    final fenNet = getNet(row[12], row[13]);
    final studentNets =
        StudentNets(turNet: turNet, matNet: matNet, fenNet: fenNet, sosNet: sosNet, ingNet: ingNet, dinNet: dinNet);

    final trialExamResult = TrialExamResult(
      studentID: student.id!,
      studentName: student.studentName ?? '',
      studentNumber: student.studentNumber ?? '',
      className: student.className ?? '',
      classID: student.classID ?? '',
      examID: trialExam.id!,
      turDog: row[2]?.value ?? 0,
      turYan: row[3]?.value ?? 0,
      turNet: turNet,
      sosDog: row[4]?.value ?? 0,
      sosYan: row[5]?.value ?? 0,
      sosNet: sosNet,
      dinDog: row[6]?.value ?? 0,
      dinYan: row[7]?.value ?? 0,
      dinNet: dinNet,
      ingDog: row[8]?.value ?? 0,
      ingYan: row[9]?.value ?? 0,
      ingNet: ingNet,
      matDog: row[10]?.value ?? 0,
      matYan: row[11]?.value ?? 0,
      matNet: matNet,
      fenDog: row[12]?.value ?? 0,
      fenYan: row[13]?.value ?? 0,
      fenNet: fenNet,
      totalPoint: getTotalPoint(studentNets, trialExam.examType),
    );
    return trialExamResult;
  }

  double getNet(Data? correctRow, Data? incorrectRow) {
    if (correctRow != null && incorrectRow != null) {
      if (correctRow.value is int && incorrectRow.value is int) {
        final net = correctRow.value - (incorrectRow.value / 3);
        return net;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  double getTotalPoint(StudentNets studentNets, int examType) {
    return (studentNets.turNet * _getFactor(factor: LgsFactors.turFactor, examType: examType)) +
        (studentNets.matNet * _getFactor(factor: LgsFactors.matFactor, examType: examType)) +
        (studentNets.fenNet * _getFactor(factor: LgsFactors.fenFactor, examType: examType)) +
        (studentNets.sosNet * LgsFactors.sosFactor) +
        (studentNets.dinNet * LgsFactors.dinFactor) +
        (studentNets.ingNet * LgsFactors.ingFactor) +
        LgsFactors.constFactor;
  }

  double _getFactor({required double factor, required int examType}) {
    if (examType == 1) {
      return (factor * 20) / 15;
    }
    return factor;
  }
}
