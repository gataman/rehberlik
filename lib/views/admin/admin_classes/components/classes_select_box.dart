import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class ClassesSelectBox extends StatelessWidget {
  ClassesSelectBox({Key? key}) : super(key: key);
  final _controller = Get.put(AdminClassesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final classesList = _controller.studentWithClassList.value;
      final selectedIndex = _controller.selectedIndex.value;

      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              if (classesList == null)
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: DefaultCircularProgress(),
                ),
              if (classesList != null)
                const Text(
                  "Sınıf Seçin",
                  style: defaultTitleStyle,
                ),
              if (classesList != null)
                DropdownButtonFormField<StudentWithClass>(
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
                  value: classesList[selectedIndex],
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (StudentWithClass? newValue) {
                    if (newValue != null) {
                      _controller.selectedIndex.value =
                          classesList.indexOf(newValue);
                      //valueChanged(newValue.classLevel);
                      //_selectedCategory = newValue.classLevel;
                    }
                  },
                  items: classesList.map<DropdownMenuItem<StudentWithClass>>(
                      (StudentWithClass value) {
                    return DropdownMenuItem<StudentWithClass>(
                      value: value,
                      child: Text(
                        value.classes.className!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                )
            ],
          ),
        ),
      );
    });
  }
}
