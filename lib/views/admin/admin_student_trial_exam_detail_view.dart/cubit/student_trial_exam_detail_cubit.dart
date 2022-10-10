import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/helper/trial_exam_graph/trial_exam_graph.dart';
import 'package:rehberlik/models/helpers/trial_exam_average_helper.dart';
import 'package:rehberlik/models/trial_exam_class_result.dart';
import 'package:rehberlik/models/trial_exam_student_result.dart';
import 'package:rehberlik/repository/trial_exam_class_result_repository.dart';
import 'package:rehberlik/repository/trial_exam_result_repository.dart';
import 'package:rehberlik/repository/trial_exam_student_result_repository.dart';

import '../../../../common/locator.dart';
import '../../../../models/student.dart';
import '../../../../models/trial_exam_result.dart';
import '../../../../repository/trial_exam_repository.dart';

part 'student_trial_exam_detail_state.dart';

class StudentTrialExamDetailCubit extends Cubit<StudentTrialExamDetailState> {
  StudentTrialExamDetailCubit() : super(StudentTrialExamLoidingState());

  final TrialExamResultRepository _trialExamResultRepository = locator<TrialExamResultRepository>();
  final TrialExamRepository _trialExamRepository = locator<TrialExamRepository>();
  final TrialExamStudentResultRepository _trialExamStudentResultRepository =
      locator<TrialExamStudentResultRepository>();
  final TrialExamClassResultRepository _trialExamClassResultRepository = locator<TrialExamClassResultRepository>();

  Student? selectedStudent;
  List<TrialExamResult>? studentTrialExamResultList;
  List<TrialExamGraph> studentTrialExamGraphList = [];
  TrialExamGraph? totalNetGraph;
  TrialExamAverageHelper? classAverages;
  TrialExamAverageHelper? schoolAverages;

  void selectStudent(Student? student) {
    if (student == null) {
      selectedStudent = null;
      _loadingState();
    } else {
      selectedStudent = student;
      _getStudentTrialExamDetail();
    }
  }

  void _getStudentTrialExamDetail() async {
    _loadingState();
    if (selectedStudent != null) {
      final list = await _trialExamResultRepository.getAll(filters: {'studentID': selectedStudent!.id});
      if (list != null && list.isNotEmpty) {
        for (var trialExamResult in list) {
          final trialExam = await _trialExamRepository.get(id: trialExamResult.examID!);
          trialExamResult.trialExam = trialExam;
        }
        list.sort(((a, b) => a.trialExam!.examDate!.compareTo(b.trialExam!.examDate!)));
      }

      studentTrialExamResultList = list;

      _setStudentTrialExamGraphList(list);

      final trialExamStudentResult = await _trialExamStudentResultRepository.get(studentID: selectedStudent!.id!);

      final trialExamClassResult =
          await _trialExamClassResultRepository.getAll(filters: {'classLevel': selectedStudent!.classLevel!});

      _calculateTrialExamClassResult(trialExamClassResult);

      emit(StudentTrialExamStudentSelectedStade(
          student: selectedStudent!,
          studentTrialExamResultList: studentTrialExamResultList,
          trialExamStudentResult: trialExamStudentResult,
          studentTrialExamGraphList: studentTrialExamGraphList,
          classAverages: classAverages,
          totalNetGraph: totalNetGraph,
          schoolAverages: schoolAverages));
    }
  }

  void _loadingState() {
    emit(StudentTrialExamLoidingState());
  }

  void _calculateTrialExamClassResult(List<TrialExamClassResult>? trialExamClassResultList) {
    if (trialExamClassResultList != null && trialExamClassResultList.isNotEmpty) {
      final groupList = trialExamClassResultList.groupBy((examClassResult) => examClassResult.className);

      double schoolTurAvg = 0;
      double schoolMatAvg = 0;
      double schoolFenAvg = 0;
      double schoolSosAvg = 0;
      double schoolIngAvg = 0;
      double schoolDinAvg = 0;
      double schoolTotalNetAvg = 0;
      double schoolPointAvg = 0;
      int schoolDataCount = 0;
      groupList.forEach((className, resultList) {
        double classTurAvg = 0;
        double classMatAvg = 0;
        double classFenAvg = 0;
        double classSosAvg = 0;
        double classIngAvg = 0;
        double classDinAvg = 0;
        double classTotalNetAvg = 0;
        double classPointAvg = 0;
        int classDataCount = 0;

        for (var examResult in resultList) {
          schoolTurAvg = schoolTurAvg + examResult.turAvg;
          schoolMatAvg = schoolMatAvg + examResult.matAvg;
          schoolFenAvg = schoolFenAvg + examResult.fenAvg;
          schoolSosAvg = schoolSosAvg + examResult.sosAvg;
          schoolIngAvg = schoolIngAvg + examResult.ingAvg;
          schoolDinAvg = schoolDinAvg + examResult.dinAvg;
          schoolPointAvg = schoolPointAvg + examResult.totPointAvg;
          schoolTotalNetAvg = schoolTotalNetAvg + examResult.totAvg;

          if (className == selectedStudent!.className) {
            classTurAvg = classTurAvg + examResult.turAvg;
            classMatAvg = classMatAvg + examResult.matAvg;
            classFenAvg = classFenAvg + examResult.fenAvg;
            classSosAvg = classSosAvg + examResult.sosAvg;
            classIngAvg = classIngAvg + examResult.ingAvg;
            classDinAvg = classDinAvg + examResult.dinAvg;
            classPointAvg = classPointAvg + examResult.totPointAvg;
            classTotalNetAvg = classTotalNetAvg + examResult.totAvg;
            classDataCount++;
          }

          schoolDataCount++;
        }

        if (className == selectedStudent!.className) {
          classTurAvg = double.parse((classTurAvg / classDataCount).toStringAsFixed(2));
          classMatAvg = double.parse((classMatAvg / classDataCount).toStringAsFixed(2));
          classFenAvg = double.parse((classFenAvg / classDataCount).toStringAsFixed(2));
          classSosAvg = double.parse((classSosAvg / classDataCount).toStringAsFixed(2));
          classIngAvg = double.parse((classIngAvg / classDataCount).toStringAsFixed(2));
          classDinAvg = double.parse((classDinAvg / classDataCount).toStringAsFixed(2));
          classPointAvg = double.parse((classPointAvg / classDataCount).toStringAsFixed(3));
          classTotalNetAvg = double.parse((classTotalNetAvg / classDataCount).toStringAsFixed(2));

          classAverages = TrialExamAverageHelper(
            turAvg: classTurAvg,
            sosAvg: classSosAvg,
            ingAvg: classIngAvg,
            dinAvg: classDinAvg,
            matAvg: classMatAvg,
            fenAvg: classFenAvg,
            totAvg: classTotalNetAvg,
            totPointAvg: classPointAvg,
          );
        }
      });

      schoolTurAvg = double.parse((schoolTurAvg / schoolDataCount).toStringAsFixed(2));
      schoolMatAvg = double.parse((schoolMatAvg / schoolDataCount).toStringAsFixed(2));
      schoolFenAvg = double.parse((schoolFenAvg / schoolDataCount).toStringAsFixed(2));
      schoolSosAvg = double.parse((schoolSosAvg / schoolDataCount).toStringAsFixed(2));
      schoolIngAvg = double.parse((schoolIngAvg / schoolDataCount).toStringAsFixed(2));
      schoolDinAvg = double.parse((schoolDinAvg / schoolDataCount).toStringAsFixed(2));
      schoolPointAvg = double.parse((schoolPointAvg / schoolDataCount).toStringAsFixed(3));
      schoolTotalNetAvg = double.parse((schoolTotalNetAvg / schoolDataCount).toStringAsFixed(2));

      schoolAverages = TrialExamAverageHelper(
        turAvg: schoolTurAvg,
        sosAvg: schoolSosAvg,
        ingAvg: schoolIngAvg,
        dinAvg: schoolDinAvg,
        matAvg: schoolMatAvg,
        fenAvg: schoolFenAvg,
        totAvg: schoolTotalNetAvg,
        totPointAvg: schoolPointAvg,
      );
    }
  }

  void _setStudentTrialExamGraphList(List<TrialExamResult>? examResultList) {
    studentTrialExamGraphList.clear();
    final turGraph = TrialExamGraph(graphLabelName: 'Türkçe', lessonType: LessonType.twenty);
    final matGraph = TrialExamGraph(graphLabelName: 'Matematik', lessonType: LessonType.twenty);
    final fenGraph = TrialExamGraph(graphLabelName: 'Fen Bilimleri', lessonType: LessonType.twenty);
    final sosGraph = TrialExamGraph(graphLabelName: 'Sosyal', lessonType: LessonType.ten);
    final ingGraph = TrialExamGraph(graphLabelName: 'İngilizce', lessonType: LessonType.ten);
    final dinGraph = TrialExamGraph(graphLabelName: 'Din', lessonType: LessonType.ten);
    final totalGraph = TrialExamGraph(graphLabelName: 'Toplam', lessonType: LessonType.total);

    if (examResultList != null && examResultList.isNotEmpty) {
      for (var examResult in examResultList) {
        turGraph.itemList.add(
            TrialExamGraphItem(itemName: examResult.trialExam!.examCode!, value: examResult.turNet!.decimalCount(2)));
        matGraph.itemList.add(
            TrialExamGraphItem(itemName: examResult.trialExam!.examCode!, value: examResult.matNet!.decimalCount(2)));
        fenGraph.itemList.add(
            TrialExamGraphItem(itemName: examResult.trialExam!.examCode!, value: examResult.fenNet!.decimalCount(2)));
        sosGraph.itemList.add(
            TrialExamGraphItem(itemName: examResult.trialExam!.examCode!, value: examResult.sosNet!.decimalCount(2)));
        ingGraph.itemList.add(
            TrialExamGraphItem(itemName: examResult.trialExam!.examCode!, value: examResult.ingNet!.decimalCount(2)));
        dinGraph.itemList.add(
            TrialExamGraphItem(itemName: examResult.trialExam!.examCode!, value: examResult.dinNet!.decimalCount(2)));
        totalGraph.itemList.add(TrialExamGraphItem(
            itemName: examResult.trialExam!.examCode!, value: _getTotalNet(examResult).decimalCount(2)));
      }
    }

    studentTrialExamGraphList.add(turGraph);
    studentTrialExamGraphList.add(matGraph);
    studentTrialExamGraphList.add(fenGraph);
    studentTrialExamGraphList.add(sosGraph);
    studentTrialExamGraphList.add(ingGraph);
    studentTrialExamGraphList.add(dinGraph);
    totalNetGraph = totalGraph;
  }

  double _getTotalNet(TrialExamResult examResult) =>
      examResult.turNet! +
      examResult.sosNet! +
      examResult.ingNet! +
      examResult.dinNet! +
      examResult.fenNet! +
      examResult.matNet!;
}
