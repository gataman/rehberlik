import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/classes_category.dart';

class ClassesLevelSelectBox extends StatelessWidget {
  final ValueChanged<int> valueChanged;
  final int selectedIndex;

  const ClassesLevelSelectBox({Key? key, required this.valueChanged, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedClass = classesCategoryList[selectedIndex];
    return DropdownButtonFormField<ClassesCategory>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: selectedClass.className,
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
      onChanged: (ClassesCategory? newValue) {
        valueChanged(classesCategoryList.indexOf(newValue!));
      },
      items: classesCategoryList.map<DropdownMenuItem<ClassesCategory>>((ClassesCategory value) {
        return DropdownMenuItem<ClassesCategory>(
          value: value,
          child: Text(
            value.className,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList(),
    );
  }
}
