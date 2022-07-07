import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
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
              if (lessonList != null && lessonList.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text("Henüz ders eklenmemiş. Lütfen ekleyin"),
                ),
              if (lessonList != null && lessonList.length > selectedIndex)
                Text(
                  "${lessonList.keys.elementAt(selectedIndex)} Sınıfı",
                  style: defaultTitleStyle,
                ),
              if (lessonList != null && lessonList.length > selectedIndex)
                _getLessonListBox(
                    lessonList.values.elementAt(selectedIndex), selectedIndex),
              if (lessonList != null && lessonList.length <= selectedIndex)
                const Text(
                    "Bu sınıf seviyesine henüz ders eklenmemiş. Lütfen ders ekleyiniz!")
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

  Widget _getLessonListBox(List<Lesson> lessonList, int selectedIndex) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
          itemCount: lessonList.length,
          itemBuilder: (context, index) {
            final lesson = lessonList[selectedIndex];
            return Container(
              decoration: defaultDividerDecoration,
              child: GestureDetector(
                onTap: () {},
                child: ListTile(
                  title: Text(lesson.lessonName!),
                ),
              ),
            );
          }),
    );
  }
}
