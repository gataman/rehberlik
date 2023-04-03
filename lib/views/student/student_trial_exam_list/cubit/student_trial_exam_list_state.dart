part of 'student_trial_exam_list_cubit.dart';

@immutable
abstract class StudentTrialExamListState {}

class ListLoadingState extends StudentTrialExamListState {}

class ListLoadedState extends StudentTrialExamListState {
  final List<TrialExam>? trialExamList;

  ListLoadedState({required this.trialExamList});
}
