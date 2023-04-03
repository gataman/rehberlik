import 'package:flutter/material.dart';

import '../../models/student.dart';

class SchoolStudentStats {
  final int classLevel;
  final Color classColor;
  List<Student>? studentList;

  SchoolStudentStats({required this.classLevel, required this.classColor, this.studentList});

  @override
  String toString() {
    return 'SchoolStudentStats{classLevel: $classLevel, classColor: $classColor, studentList : '
        '${studentList.toString()}';
  }

  static final List<SchoolStudentStats> studentStatsList = [
    SchoolStudentStats(classLevel: 5, classColor: Colors.redAccent),
    SchoolStudentStats(classLevel: 6, classColor: Colors.lime),
    SchoolStudentStats(classLevel: 7, classColor: Colors.lightBlue),
    SchoolStudentStats(classLevel: 8, classColor: Colors.amber),
  ];
}
