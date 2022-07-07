import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_classes/components/classes_data_table.dart';

class ClassesListBox extends StatefulWidget {
  const ClassesListBox({Key? key}) : super(key: key);

  @override
  State<ClassesListBox> createState() => _ClassesListBoxState();
}

class _ClassesListBoxState extends State<ClassesListBox> {
  late AdminClassesController _controller;

  List<StudentWithClass> classList = [];
  late ClassesDataSource classesDataSource;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AdminClassesController());
    if (_controller.studentWithClassList.value == null) {
      _controller.getAllStudentWithClass();
    }
    classesDataSource = ClassesDataSource(classList: classList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.white10),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          _titleClasses(),
          _classList(),
        ],
      ),
    );
  }

  Widget _titleClasses() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              "SINIFLAR",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _classList() {
    return Obx(() {
      if (_controller.studentWithClassList.value == null) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              color: infoColor,
            ),
          ),
        );
      } else {
        if (_controller.studentWithClassList.value!.isNotEmpty) {
          classesDataSource.updateList(_controller.studentWithClassList.value);
          return ClassesDataTable(classesDataSource: classesDataSource);
        } else {
          return const SizedBox(
              height: 50,
              child: Text("Sınıf eklenmemiş. Lütfen sınıf ekleyiniz!"));
        }
      }
    });
  }
}
