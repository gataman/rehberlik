import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/custom_rounded_button.dart';
import 'package:rehberlik/common/widgets/default_circular_progress.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_controller.dart';

class LessonListBox extends StatelessWidget {
  LessonListBox({Key? key}) : super(key: key);
  final _controller = Get.put(AdminLessonsController());

  @override
  Widget build(BuildContext context) {
    _getLessonList();
    return Obx(() {
      final lessonList = _controller.lessonList.value;
      final selectedIndex = _controller.selectedIndex.value;
      final selectedCategory = selectedIndex + 5;

      return Container(
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              if (lessonList == null)
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: DefaultCircularProgress(),
                ),
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
  }

  void _getLessonList() {
    if (_controller.lessonList.value == null) {
      _controller.getAllLessonList();
    }
  }

  Widget _getLessonListBox(List<Lesson> lessonList) {
    lessonList.sort((a, b) => b.lessonTime!.compareTo(a.lessonTime!));
    return SizedBox(
      height: 400,
      child: ListView.builder(
          itemCount: lessonList.length,
          itemBuilder: (context, index) {
            final lesson = lessonList[index];
            return Container(
              decoration: defaultDividerDecoration,
              child: GestureDetector(
                onTap: () {},
                child: ListTile(
                    leading: const Icon(
                      Icons.book,
                      size: 24,
                      color: infoColor,
                    ),
                    title: Text(lesson.lessonName!),
                    trailing: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${lesson.lessonTime} saat"),
                          const SizedBox(width: 16),
                          CustomRoundedButton(
                            onPressed: () {
                              _controller.editingLesson.value = lesson;
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
                      ),
                    )),
              ),
            );
          }),
    );
  }

  void _deleteLesson(Lesson lesson) {
    Get.defaultDialog(
      title: "Uyarı",
      middleText:
          "${lesson.lessonName} adlı dersi silmek istediğinizden emin misiniz?",
      contentPadding: const EdgeInsets.all(defaultPadding),
      onConfirm: () {
        _controller.deleteLesson(lesson);
        Get.back();
      },
      onCancel: () => Get.back(),
      textConfirm: "Sil",
      textCancel: "İptal",
    );
  }
}
