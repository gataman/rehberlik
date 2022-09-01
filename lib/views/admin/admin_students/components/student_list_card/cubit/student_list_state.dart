part of 'student_list_cubit.dart';

@immutable
abstract class StudentListState {}

class SelectedIndexState extends StudentListState {
  final int selectedIndex;

  SelectedIndexState({required this.selectedIndex});
}
