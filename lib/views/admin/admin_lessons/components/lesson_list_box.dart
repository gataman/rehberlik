part of admin_lessons_view;

class LessonListBox extends GetView<AdminLessonsController> {
  const LessonListBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getLessonList();

    var view = Obx(() {
      final lessonList = controller.lessonList.value;
      final selectedIndex = controller.selectedIndex.value;
      final selectedCategory = selectedIndex + 5;
      debugPrint("Obx LessonList ${lessonList.toString()} ");
      debugPrint(
          "controller LessonList id ${controller.lessonList.value.hashCode.toString()} ");
      debugPrint("LessonList.id ${lessonList.hashCode.toString()} ");
      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (lessonList == null) const DefaultCircularProgress(),
              if (lessonList != null)
                Column(
                  children: [
                    Text(
                      "$selectedCategory. Sınıf Dersler",
                      style: defaultTitleStyle,
                    ),
                    const Divider(),
                  ],
                ),
              if (lessonList != null && lessonList[selectedCategory] != null)
                _getLessonListBox(lessonList[selectedCategory]!),
              if (lessonList != null && lessonList[selectedCategory] == null)
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                      "Bu sınıf seviyesine henüz ders eklenmemiş. Lütfen ders ekleyiniz!"),
                ),
            ],
          ),
        ),
      );
    });
    debugPrint("View hascode ${view.hashCode.toString()}");
    return view;
  }

  void _getLessonList() {
    if (controller.lessonList.value == null) {
      controller.getAllLessonList();
    }
  }

  Widget _getLessonListBox(List<Lesson> lessonList) {
    lessonList.sort((a, b) => b.lessonTime!.compareTo(a.lessonTime!));
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lessonList.length,
        itemBuilder: (context, index) {
          final lesson = lessonList[index];
          return Container(
            decoration: defaultDividerDecoration,
            child: GestureDetector(
              onTap: () {
                final _subjectController = Get.put(AdminSubjectsController());
                _subjectController.subjectList.value = null;
                final data = {
                  'lessonID': lesson.id!,
                  'lessonName': lesson.lessonName!
                };
                Get.toNamed(AdminRoutes.routeSubjects, parameters: data);
              },
              child: ListTile(
                  horizontalTitleGap: 0.2,
                  leading: const Icon(
                    Icons.book,
                    size: 24,
                    color: infoColor,
                  ),
                  title: Text(lesson.lessonName!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomRoundedButton(
                        onPressed: () {
                          controller.editingLesson.value = lesson;
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomRoundedButton(
                        bgColor: Colors.redAccent,
                        iconData: Icons.delete,
                        onPressed: () {
                          _deleteLesson(lesson);
                        },
                      ),
                    ],
                  )),
            ),
          );
        });
  }

  void _deleteLesson(Lesson lesson) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${lesson.lessonName} adlı dersi silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        controller.deleteLesson(lesson);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
