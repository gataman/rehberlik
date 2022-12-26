import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'student_form_box_state.dart';

class StudentFormBoxCubit extends Cubit<StudentFormBoxState> {
  StudentFormBoxCubit() : super(SelectedIndexState(selectedIndex: 0));
}
