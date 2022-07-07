import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class StudentListBox extends StatelessWidget {
  StudentListBox({Key? key}) : super(key: key);
  final _controller = Get.put(AdminClassesController());

  @override
  Widget build(BuildContext context) {
    _getStudentAndClassList();
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
                  width: 50,
                  height: 50,
                  child: DefaultCircularProgress(),
                ),
              if (classesList != null)
                Text(
                  "${classesList[selectedIndex].classes.className} Sınıfı",
                  style: defaultTitleStyle,
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
                          child: GestureDetector(
                            onTap: () {},
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
                            ),
                          ),
                        );
                      }),
                ),
            ],
          ),
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
}
