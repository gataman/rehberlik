part of 'class_list_cubit.dart';

abstract class ClassListState {}

class ClassListLoadingState extends ClassListState {
  final List<SchoolStudentStats> schoolStatsList;

  ClassListLoadingState({required this.schoolStatsList});
}

class ClassListLoadedState extends ClassListState {
  final List<StudentWithClass>? studentWithClassList;
  final List<SchoolStudentStats> schoolStatsList;

  ClassListLoadedState({this.studentWithClassList, required this.schoolStatsList});
}
