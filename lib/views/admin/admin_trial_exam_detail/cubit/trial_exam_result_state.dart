part of 'trial_exam_result_cubit.dart';

@immutable
abstract class TrialExamResultState {}

class TrialExamResultErrorState extends TrialExamResultState {
  final String message;

  TrialExamResultErrorState({required this.message});
}

class TrialExamResultListLoadingState extends TrialExamResultState {}

class TrialExamResultListLoadedState extends TrialExamResultState {
  final List<TrialExamResult> trialExamResultList;
  TrialExamResultListLoadedState({
    required this.trialExamResultList,
  });
}

class TrialExamResultListEmptyState extends TrialExamResultState {}

class TrialExamResultUploadingState extends TrialExamResultState {}

class TrialExamResultUploadedState extends TrialExamResultState {
  final List<TrialExamResult>? trialExamResultParsedList;
  final List<int>? wrongRowList;
  final List<int>? wrongStudentList;
  final List<int>? duplicateNumberList;

  TrialExamResultUploadedState(
      {this.trialExamResultParsedList, this.wrongRowList, this.wrongStudentList, this.duplicateNumberList});
}

class TrialExamResultStaticsState extends TrialExamResultState {
  final List<TrialExamGraph> trialExamGraphList;

  TrialExamResultStaticsState({required this.trialExamGraphList});
}
