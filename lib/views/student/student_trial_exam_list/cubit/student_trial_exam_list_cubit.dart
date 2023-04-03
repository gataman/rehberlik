import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../models/trial_exam.dart';

import '../../../../common/locator.dart';
import '../../../../repository/trial_exam_repository.dart';

part 'student_trial_exam_list_state.dart';

class StudentTrialExamListCubit extends Cubit<StudentTrialExamListState> {
  StudentTrialExamListCubit() : super(ListLoadingState());

  final _trialExamRepository = locator<TrialExamRepository>();

  List<TrialExam> trialExamList = [];

  void fetchTrialExamList({required int classLevel}) async {
    emit(ListLoadingState());
    final remoteList = await _trialExamRepository.getAll(filters: {'classLevel': classLevel});
    if (remoteList != null) {
      remoteList.sort((a, b) => b.examDate!.compareTo(a.examDate!));
      trialExamList = remoteList;
      _refreshList();
    }
  }

  void _refreshList() {
    emit(ListLoadedState(trialExamList: trialExamList));
  }

  //  void _refreshList() {
  //   emit(ListLoadedState(trialExamList: _trialExamList, isLoading: false));
  // }
}
