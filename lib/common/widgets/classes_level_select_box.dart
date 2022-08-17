import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/models/classes_category.dart';

class ClassesLevelSelectBox extends StatelessWidget {
  final ValueChanged<int> valueChanged;
  final int selectedIndex;

  const ClassesLevelSelectBox(
      {Key? key, required this.valueChanged, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ClassesCategory>(
      decoration: const InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        hintStyle: TextStyle(color: Colors.white30),
        fillColor: secondaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      value: classesCategoryList[selectedIndex],
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (ClassesCategory? newValue) {
        valueChanged(classesCategoryList.indexOf(newValue!));
      },
      items: classesCategoryList
          .map<DropdownMenuItem<ClassesCategory>>((ClassesCategory value) {
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
}
