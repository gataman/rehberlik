import 'classes.dart';
import 'student.dart';

class StudentWithClass {
  Classes classes;
  List<Student>? studentList;

  StudentWithClass({required this.classes, this.studentList});

  @override
  String toString() {
    return 'StudentWithClass{classes: ${classes.toString()}, studentList: ${studentList.toString()}}';
  }
}
