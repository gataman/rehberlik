import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_controller.dart';

class AdminStudentsView extends StatelessWidget {
  AdminStudentsView({Key? key}) : super(key: key);
  final _controller = Get.put(AdminStudentsController());

  @override
  Widget build(BuildContext context) {
    _controller.getAllStudentWithClass();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Obx(
        () {
          final list = _controller.studentWithClassList.value;
          final selectedIndex = _controller.selectedIndex.value;

          return Column(
            children: [
              if (list == null)
                Column(
                  children: const [
                    Text("Öğrenciler yükleniyor lütfen bekleyin ...."),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator())
                  ],
                ),
              if (list != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: defaultBoxDecoration,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Text(
                                "${list[selectedIndex].classes.className} Sınıfı",
                                style: defaultTitleStyle,
                              ),
                            ),
                            if (list[selectedIndex].studentList != null)
                              SizedBox(
                                height: 600,
                                child: ListView.builder(
                                    itemCount:
                                        list[selectedIndex].studentList!.length,
                                    itemBuilder: (context, index) {
                                      final student = list[selectedIndex]
                                          .studentList![index];
                                      return Card(
                                        color: bgColor,
                                        elevation: 2,
                                        child: ListTile(
                                          leading: _setStudentLeading(
                                              student.photoUrl),
                                          title: Row(
                                            children: [
                                              Text(
                                                student.studentNumber!,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                width: defaultPadding,
                                              ),
                                              Text(student.studentName!,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: defaultBoxDecoration,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Text(
                                "Sınıflar",
                                style: defaultTitleStyle,
                              ),
                            ),
                            _generateClassesButton(list)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _setStudentLeading(String? photoUrl) {
    return photoUrl != null
        ? CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
          )
        : const CircleAvatar(
            backgroundImage: AssetImage(
              "${imagesSrc}profile.jpeg",
            ),
          );
  }

  Widget _generateClassesButton(List<StudentWithClass> list) {
    final children = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      final studentWithClass = list[i].classes;
      final button = SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: bgColor),
              onPressed: () {
                _controller.selectedIndex.value = i;
              },
              child: Text(
                studentWithClass.className!,
              )),
        ),
      );

      children.add(button);
    }

    return Column(
      children: children,
    );
  }
}
