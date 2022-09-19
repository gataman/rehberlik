import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_base_state.dart';

class StudentBaseCubit extends Cubit<StudentBaseState> {
  StudentBaseCubit() : super(StudentBaseExpandedState(false));

  void changeExpanded() {
    emit(StudentBaseExpandedState(!(state as StudentBaseExpandedState).isExpanded));
  }
}
