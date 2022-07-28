import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/custom_rounded_button.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class ClassListBox extends StatelessWidget {
  ClassListBox({Key? key}) : super(key: key);
  final _controller = Get.put(AdminClassesController());

  @override
  Widget build(BuildContext context) {
    _getStudentAndClassList();

    return Obx(() {
      final classesList = _controller.studentWithClassList.value;
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
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "SINIFLAR",
                  style: defaultTitleStyle,
                ),
              ),
            if (classesList != null)
              Container(
                margin: const EdgeInsets.only(bottom: defaultPadding),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: classesList.length,
                    itemBuilder: (context, index) {
                      final classes = classesList[index].classes;
                      return Container(
                        decoration: defaultDividerDecoration,
                        child: Material(
                          child: InkWell(
                            mouseCursor: SystemMouseCursors.click,
                            hoverColor: Colors.white10,
                            splashColor: bgColor,
                            onHover: (isHover) {
                              if (isHover) {
                                //debugPrint("Hover");
                              }
                            },
                            onTap: () {
                              _showClassDetail(classes, index);
                            },
                            child: ListTile(
                              leading: SvgPicture.asset(
                                "${iconsSrc}menu_classroom.svg",
                                color: Colors.white54,
                                height: 16,
                              ),
                              //leading: _setClassesLeading(student.photoUrl),
                              title: Text(classes.className!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomRoundedButton(
                                    onPressed: () {
                                      _showClassDetail(classes, index);
                                    },
                                    bgColor: Colors.blueAccent,
                                    iconData: Icons.search,
                                  ),
                                  const SizedBox(
                                    width: defaultPadding / 2,
                                  ),
                                  CustomRoundedButton(onPressed: () {
                                    _editClass(classes);
                                  }),
                                  const SizedBox(
                                    width: defaultPadding / 2,
                                  ),
                                  CustomRoundedButton(
                                      bgColor: Colors.redAccent,
                                      iconData: Icons.delete,
                                      onPressed: () {
                                        _deleteClass(classes);
                                      })
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

  void _showClassDetail(Classes classes, int index) {
    _controller.showClassDetail(classes);
    _controller.selectedIndex.value = index;
    Get.toNamed(Constants.routeStudents, id: 1);
  }

  void _editClass(Classes classes) {
    _controller.editClass(classes);
  }

  void _deleteClass(Classes classes) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${classes.className} adlı sınıfı silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        _controller.deleteClass(classes);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
