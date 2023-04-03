import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/teacher.dart';

import '../../../../core/init/locale_manager.dart';
import '../../../../core/init/pref_keys.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(TeacherState());

  TeacherType teacherType = TeacherType.teacher;

  void setTeacherType() {
    final teacher = SharedPrefs.instance.getString(PrefKeys.teacher.toString());
    if (teacher != null) {
      final decodedTeacher = Teacher.fromJson(jsonDecode(teacher)!);
      if (decodedTeacher.rank == TeacherType.admin.type) {
        teacherType = TeacherType.admin;
      }
    }
  }
}
