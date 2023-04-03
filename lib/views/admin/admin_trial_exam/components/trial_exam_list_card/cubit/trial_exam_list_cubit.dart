import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../common/locator.dart';
import '../../../../../../models/trial_exam.dart';
import '../../../../../../models/trial_exam_result.dart';
import '../../../../../../repository/trial_exam_repository.dart';
import '../../../../../../repository/trial_exam_result_repository.dart';
import '../../../../../../repository/trial_exam_student_result_repository.dart';
import '../../../../admin_trial_exam_detail/helper/trial_exam_student_result_helper.dart';

part 'trial_exam_list_state.dart';

class TrialExamListCubit extends Cubit<TrialExamListState> {
  TrialExamListCubit() : super(TrialExamListState(selectedCategory: 5));

  final _trialExamRepository = locator<TrialExamRepository>();
  final _trialExamResultRepository = locator<TrialExamResultRepository>();
  final _helperStudentResult = locator<TrialExamStudentResultHelper>();
  final _trialExamStudentResultRepository = locator<TrialExamStudentResultRepository>();
  int selectedCategory = 8;

  List<TrialExam>? _trialExamList;

  void fetchTrialExamList() async {
    final remoteList = await _trialExamRepository.getAll(filters: {'classLevel': selectedCategory});
    _trialExamList = remoteList;
    _refreshList();
  }

  void changeCategory(int category) {
    selectedCategory = category;
    fetchTrialExamList();
  }

  void _refreshList() {
    emit(TrialExamListState(selectedCategory: selectedCategory, trialExamList: _trialExamList, isLoading: false));
  }

  Future<String> addTrialExam(TrialExam trialExam) async {
    final examID = await _trialExamRepository.add(object: trialExam);
    trialExam.id = examID;
    _addTrialExamInLocalList(trialExam);

    return examID;
  }

  Future<void> updateTrialExam(TrialExam exam) async {
    return _trialExamRepository.update(object: exam).then((value) {
      _trialExamList!.sort(((a, b) => b.examDate!.compareTo(a.examDate!)));
      _refreshList();
    });
  }

  Future<void> deleteTrialExam({required TrialExam trialExam}) async {
    return _trialExamRepository.delete(objectID: trialExam.id!).whenComplete(() {
      // editingLesson.value = null;
      calculateAllStudentRanks(trialExam.classLevel!);
      _deleteTrialExamInLocalList(trialExam: trialExam);
    });
  }

  void _addTrialExamInLocalList(TrialExam trialExam) {
    if (_trialExamList != null) {
      _trialExamList!.add(trialExam);
    } else {
      _trialExamList = <TrialExam>[];
      _trialExamList!.add(trialExam);
    }
    _trialExamList!.sort(((a, b) => b.examDate!.compareTo(a.examDate!)));
    _refreshList();
  }

  void _deleteTrialExamInLocalList({required TrialExam trialExam}) {
    _trialExamList!.remove(trialExam);

    _refreshList();
  }

  void calculateAllStudentRanks(int classLevel) async {
    final List<TrialExamResult> trialExamAllResultList = [];
    debugPrint('calculatdsdss');

    // Sınıf seviyesine göre bütün sınavlar çekildi:
    final trialExamList = await _trialExamRepository.getAll(filters: {'classLevel': classLevel});

    if (trialExamList != null && trialExamList.isNotEmpty) {
      for (var exam in trialExamList) {
        final examResultList = await _trialExamResultRepository.getAll(filters: {'examID': exam.id!});
        if (examResultList != null && examResultList.isNotEmpty) {
          // Bütün listeler dolduruldu.

          trialExamAllResultList.addAll(examResultList);
        }
      }
    }

    if (trialExamAllResultList.isNotEmpty) {
      final trialExamStudentResultList = _helperStudentResult.createTrialExamStudentResultList(
          trialExamAllResultList: trialExamAllResultList, classLevel: classLevel);
      _trialExamStudentResultRepository.addAll(list: trialExamStudentResultList);
    }
  }
}
