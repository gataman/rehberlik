import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/student.dart';

class DropDownStudentList extends StatelessWidget {
  final List<Student> studentList;
  final int selectedStudentIndex;
  final Function(Student? newValue) onChanged;
  const DropDownStudentList(
      {Key? key, required this.studentList, required this.selectedStudentIndex, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedStudent = studentList[selectedStudentIndex];
    return DropdownButtonFormField<Student>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        fillColor: darkSecondaryColor,
        hintText: selectedStudent.studentName,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      value: selectedStudent,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: onChanged,
      items: studentList.map<DropdownMenuItem<Student>>((Student value) {
        return DropdownMenuItem<Student>(
          value: value,
          child: Text(
            value.studentName!,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList(),
    );
  }
}
