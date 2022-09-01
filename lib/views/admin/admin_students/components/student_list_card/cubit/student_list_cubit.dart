import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/views/admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';

part 'student_list_state.dart';

class StudentListCubit extends Cubit<SelectedIndexState> {
  StudentListCubit() : super(SelectedIndexState(selectedIndex: 0));

  void selectIndex({required int selectedIndex}) {
    emit(SelectedIndexState(selectedIndex: selectedIndex));
  }
}
