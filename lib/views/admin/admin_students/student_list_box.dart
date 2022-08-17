part of admin_students_view;

class StudentListBox extends GetView<AdminStudentsController> {
  const StudentListBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getStudentAndClassList();
    return Obx(() {
      final classesList = controller.classController.studentWithClassList.value;
      final selectedIndex = controller.classController.selectedIndex.value;

      return Container(
        decoration: defaultBoxDecoration,
        child: Column(
          children: [
            if (classesList == null)
              const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: DefaultCircularProgress(),
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
              Container(
                margin: const EdgeInsets.only(bottom: defaultPadding),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                                //debugPrint("Hover");
                              }
                            },
                            onTap: () {
                              controller.showStudentDetail(student);
                            },
                            child: ListTile(
                              horizontalTitleGap: 4.0,
                              leading: _setStudentLeading(student.photoUrl),
                              title: Text(student.studentName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              subtitle: Text(
                                "No: ${student.studentNumber.toString()}",
                                style: defaultSubtitleStyle,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomRoundedButton(onPressed: () {}),
                                  const SizedBox(
                                    width: defaultPadding / 2,
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
    if (controller.classController.studentWithClassList.value == null) {
      controller.classController.getAllStudentWithClass();
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
