import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/student_repository.dart';

part 'class_list_state.dart';

class ClassListCubit extends Cubit<ClassListState> {
  ClassListCubit() : super(ClassListState());
  final _studentRepository = locator<StudentRepository>();
  final _box = GetStorage();

  List<StudentWithClass>? studentWithClassList;

  void fetchClassList() async {
    debugPrint("fetchClassList ----> çalıştı....");
    final schoolID = _box.read("schoolID");
    var _studentWithClassList =
        await _studentRepository.getStudentWithClass(schoolID: schoolID);
    studentWithClassList = _studentWithClassList;

    _refreshList();
  }

  void _refreshList() {
    emit(ClassListState(
        studentWithClassList: studentWithClassList, isLoading: false));
  }
}
