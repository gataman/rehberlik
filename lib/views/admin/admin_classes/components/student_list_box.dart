import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/custom_rounded_button.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';

class StudentListBox extends StatelessWidget {
  StudentListBox({Key? key}) : super(key: key);
  final _controller = Get.put(AdminClassesController());
  final _adminViewController = Get.put(AdminViewController());

  @override
  Widget build(BuildContext context) {
    _getStudentAndClassList();
    return Obx(() {
      final classesList = _controller.studentWithClassList.value;
      final selectedIndex = _controller.selectedIndex.value;

      return Container(
        decoration: defaultBoxDecoration,
        child: Column(
          children: [
            if (classesList == null)
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: DefaultCircularProgress(),
                ),
              ),
            if (classesList != null)
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "${classesList[selectedIndex].classes.className} Sınıfı",
                  style: defaultTitleStyle,
                ),
              ),
            if (classesList != null)
              SizedBox(
                height: 600,
                child: ListView.builder(
                    itemCount: classesList[selectedIndex].studentList!.length,
                    itemBuilder: (context, index) {
                      final student =
                          classesList[selectedIndex].studentList![index];
                      return Container(
                        decoration: defaultDividerDecoration,
                        child: Material(
                          child: InkWell(
                            mouseCursor: SystemMouseCursors.click,
                            hoverColor: Colors.white10,
                            splashColor: bgColor,
                            onHover: (isHover) {
                              if (isHover) {
                                debugPrint("Hover");
                              }
                            },
                            onTap: () {
                              _showStudentDetail(student);
                            },
                            child: ListTile(
                              leading: _setStudentLeading(student.photoUrl),
                              title: Row(
                                children: [
                                  Text(
                                    student.studentNumber!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: defaultPadding,
                                  ),
                                  Text(student.studentName!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomRoundedButton(onPressed: () {}),
                                  const SizedBox(
                                    width: defaultPadding,
                                  ),
                                  CustomRoundedButton(
                                      bgColor: Colors.redAccent,
                                      iconData: Icons.delete,
                                      onPressed: () {})
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
          ],
        ),
      );
    });
  }

  void _getStudentAndClassList() {
    if (_controller.studentWithClassList.value == null) {
      _controller.getAllStudentWithClass();
    }
  }

  Widget _setStudentLeading(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          );
  }

  void _showStudentDetail(Student student) {
    _controller.selectedStudent.value = student;
    _adminViewController.selectMenuItem(8);
  }
}
