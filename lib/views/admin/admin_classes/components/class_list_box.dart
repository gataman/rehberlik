part of admin_classes_view;

class ClassListBox extends GetView<AdminClassesController> {
  const ClassListBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getStudentAndClassList();

    return Obx(() {
      final classesList = controller.studentWithClassList.value;
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: classesList.length,
                    itemBuilder: (context, index) {
                      final classes = classesList[index].classes;
                      return _getClassListItem(classes, index);
                    }),
              ),
          ],
        ),
      );
    });
  }

  Container _getClassListItem(Classes classes, int index) {
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
            controller.showClassDetail(classes: classes, index: index);
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
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomRoundedButton(
                  onPressed: () {
                    controller.showClassDetail(classes: classes, index: index);
                  },
                  bgColor: Colors.blueAccent,
                  iconData: Icons.search,
                ),
                const SizedBox(
                  width: defaultPadding / 2,
                ),
                CustomRoundedButton(onPressed: () {
                  controller.editClass(classes);
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
  }

  void _getStudentAndClassList() {
    if (controller.studentWithClassList.value == null) {
      controller.getAllStudentWithClass();
    }
  }

  void _deleteClass(Classes classes) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${classes.className} adlı sınıfı silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        controller.deleteClass(classes);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
