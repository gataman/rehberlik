import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class StudentInfoCard extends StatelessWidget {
  StudentInfoCard({Key? key}) : super(key: key);
  final _controller = Get.put(AdminClassesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final student = _controller.selectedStudent.value;
      if (student != null) {
        return Container(
          decoration: defaultBoxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  student.studentName.toString(),
                  textAlign: TextAlign.center,
                  style: defaultTitleStyle,
                ),
              ),
              Container(
                color: Colors.amber,
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding / 3),
                      child: SizedBox(
                          height: 80,
                          width: 80,
                          child: _setStudentProfileImage(student.photoUrl)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding / 2),
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    buildRow(
                      label: "T.C. Kimlik No",
                      value: "123456789",
                    ),
                    buildRow(
                      label: "Sınıfı",
                      value: student.className.toString(),
                    ),
                    buildRow(
                      label: "Numarası",
                      value: student.studentNumber.toString(),
                    ),
                    buildRow(
                      label: "Baba Adı",
                      value: student.fatherName.toString(),
                    ),
                    buildRow(
                      label: "Anne Adı",
                      value: student.motherName.toString(),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  TableRow buildRow({required String label, required String value}) {
    return TableRow(
      children: [
        SizedBox(
          height: 30,
          child: Text(
            label,
            style: defaultInfoTitle,
          ),
        ),
        const Text(
          ":",
          style: defaultInfoTitle,
        ),
        Text(value),
      ],
    );
  }

  Widget _setStudentProfileImage(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          );
  }
}
