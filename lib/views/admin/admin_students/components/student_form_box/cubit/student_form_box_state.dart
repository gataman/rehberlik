part of 'student_form_box_cubit.dart';

@immutable
abstract class StudentFormBoxState {}

class SelectedIndexState extends StudentFormBoxState {
  final int selectedIndex;

  SelectedIndexState({required this.selectedIndex});
}
