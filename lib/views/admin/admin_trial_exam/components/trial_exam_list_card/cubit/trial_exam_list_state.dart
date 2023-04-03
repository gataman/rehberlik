part of 'trial_exam_list_cubit.dart';

class TrialExamListState {
  final bool isLoading;
  final int selectedCategory;
  final List<TrialExam>? trialExamList;

  TrialExamListState(
      {required this.selectedCategory,
      this.trialExamList,
      this.isLoading = true});
}
