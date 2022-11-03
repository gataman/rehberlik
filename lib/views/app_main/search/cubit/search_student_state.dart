part of 'search_student_cubit.dart';

@immutable
abstract class SearchStudentState {}

class SearchStudentInitial extends SearchStudentState {
  final List<Student>? searchedStudentList;

  SearchStudentInitial({this.searchedStudentList});
}
