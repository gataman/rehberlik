import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'student_list_state.dart';

class StudentListCubit extends Cubit<SelectedIndexState> {
  StudentListCubit() : super(SelectedIndexState(selectedIndex: 0));

  void selectIndex({required int selectedIndex}) {
    emit(SelectedIndexState(selectedIndex: selectedIndex));
  }
}
