part of 'student_base_cubit.dart';

abstract class StudentBaseState {}

class StudentBaseExpandedState extends StudentBaseState {
  final bool isExpanded;

  StudentBaseExpandedState(this.isExpanded);
}
