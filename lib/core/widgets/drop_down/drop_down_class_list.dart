import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/student_with_class.dart';

class DropDownClassList extends StatelessWidget {
  final List<StudentWithClass> classesList;
  final int selectedIndex;
  final Function(StudentWithClass? newValue) onChanged;
  const DropDownClassList({Key? key, required this.classesList, required this.selectedIndex, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedClass = classesList[selectedIndex];
    return DropdownButtonFormField<StudentWithClass>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: selectedClass.classes.className,
        fillColor: darkSecondaryColor,
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
      value: selectedClass,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: onChanged,
      items: classesList.map<DropdownMenuItem<StudentWithClass>>((StudentWithClass value) {
        return DropdownMenuItem<StudentWithClass>(
          value: value,
          child: Text(
            value.classes.className!,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList(),
    );
  }
}
