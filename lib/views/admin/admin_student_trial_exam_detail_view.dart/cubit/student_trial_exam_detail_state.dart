part of 'student_trial_exam_detail_cubit.dart';

@immutable
abstract class StudentTrialExamDetailState {}

class StudentTrialExamLoidingState extends StudentTrialExamDetailState {}

class StudentTrialExamStudentSelectedStade extends StudentTrialExamDetailState {
  final Student student;

  StudentTrialExamStudentSelectedStade({required this.student});
}
