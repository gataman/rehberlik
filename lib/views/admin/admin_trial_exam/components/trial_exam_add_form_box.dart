part of admin_trial_exam_view;

class TrialExamAddFormBox extends StatefulWidget {
  const TrialExamAddFormBox({Key? key}) : super(key: key);

  @override
  State<TrialExamAddFormBox> createState() => _TrialExamAddFormBoxState();
}

class _TrialExamAddFormBoxState extends State<TrialExamAddFormBox> {
  final _controller = Get.put(AdminTrialExamController());
  final _tfTrialEcamFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _trialExamNameFocusNode;
  TrialExam? _trialExam;

  @override
  void initState() {
    _trialExamNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfTrialEcamFormController.dispose();

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
            _trialExam = _controller.editingTrialExam.value;
            final selectedClassLevel = _controller.selectedClassLevel;
            final selectedIndex = selectedClassLevel - 5;
            if (_trialExam != null) {
              _trialExamNameFocusNode.requestFocus();
              _tfTrialEcamFormController.text = _trialExam!.examName!;
            } else {
              _tfTrialEcamFormController.text = "";
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
                        valueChanged: (index) {
                          _controller.getAllTrialExam(classLevel: index + 5);
                        },
                        selectedIndex: selectedIndex,
                      ),
                      _trialExamNameInput(),
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
        if (_trialExam != null)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: warningColor,
              ),
              onPressed: () {
                _controller.editingTrialExam.value = null;
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
        if (_trialExam != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: _trialExam == null ? Colors.amber : infoColor,
              ),
              onPressed: () {
                if (_trialExam == null) {
                  _saveSubject();
                } else {
                  _editSubject(_trialExam);
                }
              },
              child: Row(
                children: [
                  if (_controller.statusAddingTrialExam.value)
                    const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        )),
                  if (!_controller.statusAddingTrialExam.value)
                    const SizedBox(
                        child: Icon(
                      Icons.save,
                      color: secondaryColor,
                    )),
                  Expanded(
                    child: Center(
                      child: Text(
                        _trialExam == null ? "Kaydet" : "Güncelle",
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

  Widget _trialExamNameInput() {
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
      focusNode: _trialExamNameFocusNode,
      textInputAction: TextInputAction.go,
      controller: _tfTrialEcamFormController,
      style: TextStyle(color: _trialExam == null ? Colors.amber : infoColor),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: _trialExam == null ? "Sınav Adı" : _trialExam?.examName,
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
        _trialExam == null ? "Konu Ekle" : "Konu Güncelle",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _trialExam == null ? Colors.amber : infoColor,
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

      /*
      final TrialExam trialExam = Subject(
          lessonID: widget.lessonID,
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

       */
    }
  }

  void _editSubject(TrialExam? trialExam) {
    if (trialExam != null) {
      trialExam.examName = _tfTrialEcamFormController.text;

      /*
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

       */
    }
  }
}
