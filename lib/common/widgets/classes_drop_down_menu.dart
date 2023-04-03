import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/classes_category.dart';

// ignore: must_be_immutable
class ClassesDropDownMenu extends StatelessWidget {
  final ValueChanged<int> valueChanged;
  var _selectedCategory = 8;

  ClassesDropDownMenu({Key? key, required this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedClassCategory = getClassesCategory(_selectedCategory);
    return DropdownButtonFormField<ClassesCategory>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: selectedClassCategory!.className,
        fillColor: darkSecondaryColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      value: selectedClassCategory,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (ClassesCategory? newValue) {
        if (newValue != null) {
          valueChanged(newValue.classLevel);
          _selectedCategory = newValue.classLevel;
        }
      },
      items: classesCategoryList.map<DropdownMenuItem<ClassesCategory>>((ClassesCategory value) {
        return DropdownMenuItem<ClassesCategory>(
          value: value,
          child: Text(
            value.className,
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
    );
  }

  ClassesCategory? getClassesCategory(int classLevel) {
    return classesCategoryList.where((element) => element.classLevel == classLevel).first;
  }
}
