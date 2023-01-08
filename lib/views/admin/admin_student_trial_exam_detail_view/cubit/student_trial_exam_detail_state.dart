part of 'student_trial_exam_detail_cubit.dart';

@immutable
abstract class StudentTrialExamDetailState {}

class StudentTrialExamLoidingState extends StudentTrialExamDetailState {}

class StudentTrialExamStudentSelectedStade extends StudentTrialExamDetailState {
  final Student student;
  final List<TrialExamResult>? studentTrialExamResultList;
  final List<TrialExamGraph>? studentTrialExamGraphList;
  final TrialExamStudentResult? trialExamStudentResult;
  final TrialExamAverageHelper? classAverages;
  final TrialExamAverageHelper? schoolAverages;
  final TrialExamGraph? totalNetGraph;
  final List<TrialExamClassResult>? trialExamClassResult;

  StudentTrialExamStudentSelectedStade({
    required this.student,
    this.studentTrialExamResultList,
    this.trialExamStudentResult,
    this.studentTrialExamGraphList,
    this.classAverages,
    this.schoolAverages,
    this.totalNetGraph,
    this.trialExamClassResult,
  });
}
