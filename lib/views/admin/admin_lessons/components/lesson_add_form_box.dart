part of admin_lessons_view;

class LessonAddFormBox extends StatefulWidget {
  const LessonAddFormBox({Key? key}) : super(key: key);

  @override
  State<LessonAddFormBox> createState() => _LessonAddFormBoxState();
}

class _LessonAddFormBoxState extends State<LessonAddFormBox> {
  final _controller = Get.put(AdminLessonsController());
  final _tfLessonNameFormController = TextEditingController();
  final _tfLessonTimeFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _lessonNameFocusNode;
  Lesson? _lesson;

  @override
  void initState() {
    _lessonNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfLessonNameFormController.dispose();
    _tfLessonTimeFormController.dispose();

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
              _tfLessonNameFormController.text = _lesson!.lessonName!;
              _tfLessonTimeFormController.text =
                  _lesson!.lessonTime!.toString();
            } else {
              _tfLessonNameFormController.text = "";
              _tfLessonTimeFormController.text = "";
            }

            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    direction: Axis.horizontal,
                    children: [
                      _title(),
                      ClassesLevelSelectBox(
                        valueChanged: (_index) {
                          _controller.selectedIndex.value = _index;
                        },
                        selectedIndex: _controller.selectedIndex.value,
                      ),
                      _lessonNameInput(),
                      _lessonTimeInput(),
                      _actionButtons(),
                    ],
                  ),
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

  Widget _lessonNameInput() {
    return TextFormField(
      validator: (text) {
        debugPrint("...$text");
        if (text == null || text.trim().isEmpty) {
          return "Lütfen ders adı yazınız!";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        _saveLesson();
      },
      focusNode: _lessonNameFocusNode,
      textInputAction: TextInputAction.go,
      controller: _tfLessonNameFormController,
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
    );
  }

  Widget _lessonTimeInput() {
    return TextFormField(
      validator: (text) {
        debugPrint("...$text");
        if (text == null || text.trim().isEmpty) {
          return "Lütfen ders saati yazınız!";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        _saveLesson();
      },
      controller: _tfLessonTimeFormController,
      style: TextStyle(color: _lesson == null ? Colors.amber : infoColor),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText:
            _lesson == null ? "Ders Saati" : _lesson?.lessonTime.toString(),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Text(
        _lesson == null ? "Ders Ekle" : "Ders Güncelle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _lesson == null ? Colors.amber : infoColor,
        ),
      ),
    );
  }

  void _saveLesson() {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }

      final Lesson lesson = Lesson(
          schoolID: "w7WZvgcVPKVheXnhxMHE",
          lessonName: _tfLessonNameFormController.text,
          classLevel: _controller.selectedIndex.value + 5,
          lessonTime: int.parse(_tfLessonTimeFormController.text));
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
      lesson.lessonName = _tfLessonNameFormController.text;
      var oldClass = lesson.classLevel;
      lesson.classLevel = _controller.selectedIndex.value + 5;
      _controller.updateLesson(lesson, oldClass!);
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
