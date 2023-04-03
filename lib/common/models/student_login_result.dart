// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/student.dart';

class StudentLoginResult {
  String message;
  bool isSuccess;
  Student? student;
  StudentLoginResult({
    required this.message,
    required this.isSuccess,
    this.student,
  });

  @override
  String toString() {
    return 'StudentLoginResult{message: $message, isSuccess: $isSuccess,  student: $student,}';
  }
}
