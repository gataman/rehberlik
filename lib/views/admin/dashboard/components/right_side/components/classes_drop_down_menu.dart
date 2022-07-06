import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';

class ClassesDropDownMenu extends StatelessWidget {
  final ValueChanged<int> valueChanged;
  var _selectedCategory = 8;

  ClassesDropDownMenu({Key? key, required this.valueChanged}) : super(key: key);

  final classesCategoryList = <ClassesCategory>[
    ClassesCategory(classIndex: 0, className: "5.Sınıflar", classLevel: 5),
    ClassesCategory(classIndex: 1, className: "6.Sınıflar", classLevel: 6),
    ClassesCategory(classIndex: 2, className: "7.Sınıflar", classLevel: 7),
    ClassesCategory(classIndex: 3, className: "8.Sınıflar", classLevel: 8),
  ];

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
      value: getClassesCategory(_selectedCategory),
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (ClassesCategory? newValue) {
        if (newValue != null) {
          valueChanged(newValue.classLevel);
          _selectedCategory = newValue.classLevel;
        }
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

  ClassesCategory? getClassesCategory(int classLevel) {
    return classesCategoryList
        .where((element) => element.classLevel == classLevel)
        .first;
  }
}

class ClassesCategory {
  int classIndex;
  String className;
  int classLevel;

  ClassesCategory(
      {required this.classIndex,
      required this.className,
      required this.classLevel});
}
