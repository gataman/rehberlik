// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/helper/excel_creator/exam_card_generator/student_exam_card_creator.dart';
import 'package:rehberlik/common/helper/excel_creator/exam_card_generator/student_hall_list_creator.dart';

import 'package:rehberlik/models/student_with_class.dart';

import '../../../../models/student.dart';

class ExamHallBuilder {
  final List<StudentWithClass> classesList;

  ExamHallBuilder({required this.classesList});

  void build({required}) async {
    final mapList = _generateClassList();
    final hallList = _generateHallList();

    _addStudentsToHall15(studentMap: mapList, hallList: hallList);
    StudentExamCardCreator creator = StudentExamCardCreator();
    //StudentHallListCreator creator = StudentHallListCreator();
    //await creator.build(hallList);

    for (var hall in hallList) {
      debugPrint('___________________________');
      debugPrint('Salon No : ${hall.hallNumber}');
      debugPrint('Öğrenciler _______}');
      for (var studentWithExamOrder in hall.studentWithExamOrderList) {
        debugPrint(
            '${studentWithExamOrder.order} - ${studentWithExamOrder.student?.className} - ${studentWithExamOrder.student?.studentName}- ${studentWithExamOrder.student?.gender}');
      }
      debugPrint('___________________________');
    }
  }

  Map<String, List<Student>> _generateClassList() {
    final class8AList = classesList.where((element) => element.classes.className == '8-A').toList();
    final class8BList = classesList.where((element) => element.classes.className == '8-B').toList();
    final class8CList = classesList.where((element) => element.classes.className == '8-C').toList();
    final class8DList = classesList.where((element) => element.classes.className == '8-D').toList();

    final findAmac = class8BList.first.studentList!.findOrNull((element) => element.studentNumber == '205');
    if (findAmac != null) {
      class8BList.first.studentList!.remove(findAmac);
    }

    Map<String, List<Student>> map = {
      '8A': class8AList.first.studentList!,
      '8B': class8BList.first.studentList!,
      '8C': class8CList.first.studentList!,
      '8D': class8DList.first.studentList!,
    };

    return map;
  }

  List<ExamHall> _generateHallList() {
    return List.generate(
        7, (index) => ExamHall(hallNumber: index + 1, hallName: 'Salon${index + 1}', studentWithExamOrderList: []));
  }

  void _addStudentsToHall({required Map<String, List<Student>> studentMap, required List<ExamHall> hallList}) {
    for (var hall in hallList) {
      for (var i = 1; i <= 12; i++) {
        if (i == 1 || i == 6 || i == 9) {
          _addStudent(studentMap['8A']!, hall, i);
        } else if (i == 2 || i == 5 || i == 10) {
          _addStudent(studentMap['8B']!, hall, i);
        } else if (i == 3 || i == 8 || i == 11) {
          _addStudent(studentMap['8C']!, hall, i);
        } else {
          _addStudent(studentMap['8D']!, hall, i);
        }
      }
    }
  }

  void _addStudentsToHall15({required Map<String, List<Student>> studentMap, required List<ExamHall> hallList}) {
    for (var hall in hallList) {
      for (var i = 1; i <= 15; i++) {
        if (i == 1 || i == 5 || i == 8 || i == 11) {
          _addStudent(studentMap['8A']!, hall, i);
        } else if (i == 2 || i == 7 || i == 12) {
          _addStudent(studentMap['8B']!, hall, i);
        } else if (i == 3 || i == 6 || i == 10 || i == 13) {
          _addStudent(studentMap['8C']!, hall, i);
        } else if (i == 15) {
          if (studentMap['8B']!.isNotEmpty) {
            _addStudent(studentMap['8B']!, hall, i);
          } else {
            _addStudent(studentMap['8D']!, hall, i);
          }
        } else {
          _addStudent(studentMap['8D']!, hall, i);
        }
      }
    }
  }

  void _addStudentsToHall16({required Map<String, List<Student>> studentMap, required List<ExamHall> hallList}) {
    for (var hall in hallList) {
      for (var i = 1; i <= 16; i++) {
        if (i == 1 || i == 5 || i == 8 || i == 11) {
          _addStudent(studentMap['8A']!, hall, i);
        } else if (i == 2 || i == 7 || i == 12) {
          _addStudent(studentMap['8B']!, hall, i);
        } else if (i == 3 || i == 6 || i == 10 || i == 13) {
          _addStudent(studentMap['8C']!, hall, i);
        } else if (i == 15) {
          if (studentMap['8B']!.isNotEmpty) {
            _addStudent(studentMap['8B']!, hall, i);
          } else {
            _addStudent(studentMap['8D']!, hall, i);
          }
        } else {
          _addStudent(studentMap['8D']!, hall, i);
        }
      }
    }
  }

  void _addStudent(List<Student> studentList, ExamHall hall, int i) {
    if (studentList.isNotEmpty) {
      List<Student> lastList = [];
      final girlList = studentList.where((element) => element.gender == 'Kız').toList();
      final boyList = studentList.where((element) => element.gender == 'Erkek').toList();
      if (!i.isOdd && girlList.isNotEmpty) {
        lastList = girlList;
      } else if (boyList.isNotEmpty) {
        lastList = boyList;
      } else {
        lastList = girlList;
      }

      if (lastList.isNotEmpty) {
        StudentWithExamOrder studentWithExamOrder = StudentWithExamOrder(order: i, examHall: hall);
        final student = (lastList..shuffle()).first;

        studentWithExamOrder.student = student;
        hall.studentWithExamOrderList.add(studentWithExamOrder);
        studentList.remove(student);
      }
    }
  }
}

// Sınav Salonu:
class ExamHall {
  final int hallNumber;
  final String hallName;
  final List<StudentWithExamOrder> studentWithExamOrderList;

  ExamHall({required this.hallNumber, required this.hallName, required this.studentWithExamOrderList});

  @override
  String toString() =>
      'ExamHall(hallNumber: $hallNumber, hallName: $hallName, studentWithExamOrderList: $studentWithExamOrderList)';
}

class StudentWithExamOrder {
  final int order;
  final ExamHall examHall;
  Student? student;

  StudentWithExamOrder({required this.order, required this.examHall});

  @override
  String toString() => 'StudentWithExamOrder(order: $order, student: $student)';
}
