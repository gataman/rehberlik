part of 'student_list_cubit.dart';

@immutable
abstract class StudentListState {}

class SelectedIndexState extends StudentListState {
  final int classIndex;
  final int studentIndex;

  SelectedIndexState({required this.classIndex, this.studentIndex = 0});
}
