part of 'trial_exam_total_cubit.dart';

@immutable
abstract class TrialExamTotalState {}

class TrialExamTotalLoadingState extends TrialExamTotalState {}

class TrialExamTotalLoadedState extends TrialExamTotalState {
  final List<TrialExamStudentResult>? trialExamStudentResult;

  TrialExamTotalLoadedState({this.trialExamStudentResult});
}

class TrialExamTotalGraphState extends TrialExamTotalState {
  final List<TrialExamGraph> trialExamGraphList;

  TrialExamTotalGraphState({required this.trialExamGraphList});
}
