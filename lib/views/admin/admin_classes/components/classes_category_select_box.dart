import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class ClassesCategorySelectBox extends StatefulWidget {
  final ValueChanged<int> valueChanged;

  const ClassesCategorySelectBox({Key? key, required this.valueChanged})
      : super(key: key);

  @override
  State<ClassesCategorySelectBox> createState() =>
      _ClassesCategorySelectBoxState();
}

class _ClassesCategorySelectBoxState extends State<ClassesCategorySelectBox> {
  final _controller = Get.put(AdminClassesController());

  final classesCategoryList = <ClassesCategory>[
    ClassesCategory(classIndex: 0, className: "5.Sınıflar", classLevel: 5),
    ClassesCategory(classIndex: 1, className: "6.Sınıflar", classLevel: 6),
    ClassesCategory(classIndex: 2, className: "7.Sınıflar", classLevel: 7),
    ClassesCategory(classIndex: 3, className: "8.Sınıflar", classLevel: 8),
  ];

  @override
  void dispose() {
    _controller.editingClasses.value = null;
    _controller.selectedClassesCategory.value = 5;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<ClassesCategory>(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: -5, horizontal: defaultPadding / 2),
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
        value: getClassesCategory(_controller.selectedClassesCategory.value),
        icon: const Icon(Icons.keyboard_arrow_down),
        onChanged: (ClassesCategory? newValue) {
          widget.valueChanged(newValue!.classLevel);
          _controller.selectedClassesCategory.value = newValue.classLevel;
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
    });
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
