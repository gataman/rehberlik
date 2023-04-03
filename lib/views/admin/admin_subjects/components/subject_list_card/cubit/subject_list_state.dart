part of 'subject_list_cubit.dart';

@immutable
abstract class SubjectListState {}

class SubjectListLoadingState extends SubjectListState {}

class SubjectListLoadedState extends SubjectListState {
  final List<Subject> subjectList;

  SubjectListLoadedState(this.subjectList);
}
