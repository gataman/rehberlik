part of admin_subjects_view;

class SubjectAddFormBox extends StatefulWidget {
  const SubjectAddFormBox({Key? key}) : super(key: key);

  @override
  State<SubjectAddFormBox> createState() => _SubjectAddFormBoxState();
}

class _SubjectAddFormBoxState extends State<SubjectAddFormBox> {
  final _controller = Get.put(AdminSubjectsController());
  final _tfSubjectNameFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _subjectNameFocusNode;
  Subject? _subject;

  @override
  void initState() {
    _subjectNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfSubjectNameFormController.dispose();

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
            _subject = _controller.editingSubject.value;
            if (_subject != null) {
              _subjectNameFocusNode.requestFocus();
              _tfSubjectNameFormController.text = _subject!.subject!;
            } else {
              _tfSubjectNameFormController.text = "";
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
                      _subjectNameInput(),
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
        if (_subject != null)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: warningColor,
              ),
              onPressed: () {
                _controller.editingSubject.value = null;
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
        if (_subject != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _subject == null ? Colors.amber : infoColor,
              ),
              onPressed: () {
                if (_subject == null) {
                  _saveSubject();
                } else {
                  _editSubject(_subject);
                }
              },
              child: Row(
                children: [
                  if (_controller.statusAddingSubject.value)
                    const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                  if (!_controller.statusAddingSubject.value)
                    const SizedBox(
                        child: Icon(
                      Icons.save,
                      color: secondaryColor,
                    )),
                  Expanded(
                    child: Center(
                      child: Text(
                        _subject == null ? "Kaydet" : "Güncelle",
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

  Widget _subjectNameInput() {
    return TextFormField(
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return "Lütfen ders adı yazınız!";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        _saveSubject();
      },
      focusNode: _subjectNameFocusNode,
      textInputAction: TextInputAction.go,
      controller: _tfSubjectNameFormController,
      style: TextStyle(color: _subject == null ? Colors.amber : infoColor),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: _subject == null ? "Konu Adı" : _subject?.subject,
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
        _subject == null ? "Konu Ekle" : "Konu Güncelle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _subject == null ? Colors.amber : infoColor,
        ),
      ),
    );
  }

  void _saveSubject() {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      final params = Get.parameters;

      final Subject subject = Subject(
          lessonID: params['lessonID'],
          subject: _tfSubjectNameFormController.text);
      _controller.addSubject(subject).then((value) {
        _tfSubjectNameFormController.text = "";
        Get.snackbar(
          "Başarılı",
          "Konu başarıyla eklendi",
          duration: const Duration(seconds: 2),
          colorText: secondaryColor,
          backgroundColor: infoColor,
        );
      });
    }
  }

  void _editSubject(Subject? subject) {
    if (subject != null) {
      subject.subject = _tfSubjectNameFormController.text;

      _controller.updateSubject(subject).then((value) {
        Get.snackbar(
          "Başarılı",
          "Sınıf adı başarıyla güncellendi",
          duration: const Duration(seconds: 2),
          colorText: secondaryColor,
          backgroundColor: infoColor,
        );
        _tfSubjectNameFormController.text = "";
        _controller.editingSubject.value = null;
      });
    }
  }
}
