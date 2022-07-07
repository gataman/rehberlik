import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/views/admin/admin_classes/components/classes_category_select_box.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_controller.dart';

class LessonAddFormBox extends StatefulWidget {
  const LessonAddFormBox({Key? key}) : super(key: key);

  @override
  State<LessonAddFormBox> createState() => _LessonAddFormBoxState();
}

class _LessonAddFormBoxState extends State<LessonAddFormBox> {
  final _controller = Get.put(AdminLessonsController());
  final _tfAddFormController = TextEditingController();
  int _selectedCategory = 8;
  late FocusNode _lessonNameFocusNode;
  Lesson? _lesson;

  @override
  void initState() {
    _lessonNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfAddFormController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: Colors.white10),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Obx(
          () {
            _lesson = _controller.editingLesson.value;
            if (_lesson != null) {
              _lessonNameFocusNode.requestFocus();
              _tfAddFormController.text = _lesson!.lessonName!;
            } else {
              _tfAddFormController.text = "";
            }

            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  direction: Axis.horizontal,
                  children: [
                    _title(),
                    ClassesCategorySelectBox(valueChanged: (classCategory) {
                      _selectedCategory = classCategory;
                      debugPrint(
                          "Seçilen  class add form Sınıf : $classCategory");
                    }),
                    _classNameInput(),
                    _actionButtons(),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (_lesson != null)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: warningColor,
              ),
              onPressed: () {
                _controller.editingLesson.value = null;
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.cancel,
                    color: secondaryColor,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "İptal",
                        style: TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (_lesson != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _lesson == null ? Colors.amber : infoColor,
              ),
              onPressed: () {
                if (_lesson == null) {
                  _saveLesson();
                } else {
                  _editLesson(_lesson);
                }
              },
              child: Row(
                children: [
                  if (_controller.statusAddingLesson.value)
                    const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                  if (!_controller.statusAddingLesson.value)
                    const SizedBox(
                        child: Icon(
                      Icons.save,
                      color: secondaryColor,
                    )),
                  Expanded(
                    child: Center(
                      child: Text(
                        _lesson == null ? "Kaydet" : "Güncelle",
                        style: const TextStyle(
                            color: secondaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget _classNameInput() {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onFieldSubmitted: (value) {
          _saveLesson();
        },
        focusNode: _lessonNameFocusNode,
        textInputAction: TextInputAction.go,
        controller: _tfAddFormController,
        style: TextStyle(color: _lesson == null ? Colors.amber : infoColor),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: _lesson == null ? "Ders Adı" : _lesson?.lessonName,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Text(
        _lesson == null ? "Sınıf Ekle" : "Sınıf Güncelle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _lesson == null ? Colors.amber : infoColor,
        ),
      ),
    );
  }

  void _saveLesson() {
    if (_tfAddFormController.text.trim().isEmpty) {
      debugPrint("Boşşş");
    } else {
      debugPrint(_tfAddFormController.text.toString());

      final Lesson lesson = Lesson(
          schoolID: "w7WZvgcVPKVheXnhxMHE",
          lessonName: _tfAddFormController.text,
          classLevel: _selectedCategory,
          lessonTime: 5);
      _controller.addLesson(lesson);

      Get.snackbar(
        "Başarılı",
        "Sınıf başarıyla eklendi",
        duration: const Duration(seconds: 2),
        colorText: secondaryColor,
        backgroundColor: infoColor,
      );
    }
  }

  void _editLesson(Lesson? lesson) {
    if (lesson != null) {
      if (_tfAddFormController.text.trim().isEmpty) {
        debugPrint("Boşşş");
      } else {
        lesson.lessonName = _tfAddFormController.text;
        lesson.classLevel = _selectedCategory;
        _controller.updateLesson(lesson);
        Get.snackbar(
          "Başarılı",
          "Sınıf adı başarıyla güncellendi",
          duration: const Duration(seconds: 2),
          colorText: secondaryColor,
          backgroundColor: infoColor,
        );
      }
    }
  }
}
