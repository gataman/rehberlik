part of 'study_program_list_cubit.dart';

class StudyProgramListState {
  final bool isLoading;
  final List<StudyProgram>? studyProgramList;

  StudyProgramListState({this.isLoading = true, this.studyProgramList});
}
