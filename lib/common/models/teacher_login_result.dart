// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../models/teacher.dart';

class TeacherLoginResult {
  String message;
  bool isSuccess;
  Teacher? teacher;
  TeacherLoginResult({
    required this.message,
    required this.isSuccess,
    this.teacher,
  });

  @override
  String toString() {
    return 'TeacherLoginResult{message: $message, isSuccess: $isSuccess,  teacher: $teacher,}';
  }
}
