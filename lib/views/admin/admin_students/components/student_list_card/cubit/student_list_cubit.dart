import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'student_list_state.dart';

class StudentListCubit extends Cubit<SelectedIndexState> {
  StudentListCubit() : super(SelectedIndexState(classIndex: 15));

  int classIndex = 15;
  int studentIndex = 0;

  void selectClass({required int selectedIndex}) {
    classIndex = selectedIndex;
    emit(SelectedIndexState(classIndex: classIndex));
  }

  void selectStudent({required int selectedIndex}) {
    studentIndex = selectedIndex;
    emit(SelectedIndexState(classIndex: classIndex, studentIndex: studentIndex));
  }
}
