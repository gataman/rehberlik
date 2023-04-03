import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:turkish/turkish.dart';

import '../../../../models/student.dart';

part 'search_student_state.dart';

class SearchStudentCubit extends Cubit<SearchStudentState> {
  SearchStudentCubit() : super(SearchStudentInitial());
  List<Student>? allStudentList;
  List<Student>? searchedStudentList;

  void init(List<Student>? studentList) {
    allStudentList = studentList;
    searchedStudentList = studentList;
    emit(SearchStudentInitial(searchedStudentList: studentList));
  }

  void search(String value) {
    if (allStudentList != null) {
      if (value.length > 1) {
        searchedStudentList = allStudentList!
            .where(
              (element) => (element.studentName!.toUpperCaseTr().contains(value.toUpperCaseTr()) ||
                  element.studentNumber!.contains(value)),
            )
            .toList();
        emit(SearchStudentInitial(searchedStudentList: searchedStudentList));
      } else {
        emit(SearchStudentInitial(searchedStudentList: allStudentList));
      }
    }
  }
}
