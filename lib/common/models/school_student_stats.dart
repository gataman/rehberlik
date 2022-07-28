import 'package:flutter/material.dart';

class SchoolStudentStats {
  final int classLevel;
  int studentCount;
  final Color classColor;

  SchoolStudentStats(
      {required this.classLevel,
      required this.classColor,
      this.studentCount = 0});

  @override
  String toString() {
    return 'SchoolStudentStats{classLevel: $classLevel, studentCount: $studentCount, classColor: $classColor}';
  }
}
