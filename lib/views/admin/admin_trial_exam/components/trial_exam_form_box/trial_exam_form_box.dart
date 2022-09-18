part of admin_trial_exam_view;

class TrialExamAddFormBox extends StatefulWidget {
  const TrialExamAddFormBox({Key? key}) : super(key: key);

  @override
  State<TrialExamAddFormBox> createState() => _TrialExamAddFormBoxState();
}

class _TrialExamAddFormBoxState extends State<TrialExamAddFormBox> {
  final _tfTrialExamFormController = TextEditingController();
  final _tfTrialExamCodeFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _trialExamNameFocusNode;
  TrialExam? _trialExam;
  int _selectedIndex = 0;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

  @override
  void initState() {
    _trialExamNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfTrialExamFormController.dispose();
    _tfTrialExamCodeFormController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = context.read<TrialExamListCubit>().selectedCategory - 5;
    return Container(
      decoration: BoxDecoration(
          color: darkSecondaryColor,
          border: Border.all(color: Colors.white10),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: BlocBuilder<TrialExamFormBoxCubit, TrialExamFormBoxState>(builder: (context, state) {
        _trialExam = state is EditTrialExamState ? state.editTrialExam : null;

        if (_trialExam != null) {
          _trialExamNameFocusNode.requestFocus();
          _tfTrialExamFormController.text = _trialExam!.examName!;
          _tfTrialExamCodeFormController.text = _trialExam!.examCode!;
        } else {
          _resetForm();
        }

        return Column(
          children: [
            _title(),
            AppFormBoxElements(formKey: _formKey, children: [
              ClassesLevelSelectBox(
                valueChanged: (index) {
                  context.read<TrialExamListCubit>().changeCategory(index + 5);
                },
                selectedIndex: _selectedIndex,
              ),
              _trialExamNameInput(),
              _trialExamCodeInput(),
              _actionButtons(),
            ]),
          ],
        );
      }),
    );
  }

  void _resetForm() {
    _tfTrialExamFormController.text = "";
    _tfTrialExamCodeFormController.text = "";
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (_trialExam != null)
          Expanded(
            child: AppCancelFormButton(
              onPressed: () {
                context.read<TrialExamFormBoxCubit>().editTrialExam(trialExam: null);
              },
            ),
          ),

        if (_trialExam != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),

        Expanded(
          child: LoadingButton(
            text: _trialExam == null ? LocaleKeys.actions_save.locale() : LocaleKeys.actions_update.locale(),
            loadingListener: buttonListener,
            onPressed: () {
              if (_trialExam == null) {
                _saveTrialExam();
              } else {
                _editSubject(_trialExam);
              }
            },
            backColor: _trialExam == null ? Colors.amber : infoColor,
            textColor: darkSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _trialExamNameInput() {
    return AppOutlineTextFormField(
      isStyleDifferent: _trialExam == null,
      validateText: LocaleKeys.trialExams_trialExamNameEmptyAlert.locale(),
      onFieldSubmitted: (value) {
        _saveTrialExam();
      },
      focusNode: _trialExamNameFocusNode,
      controller: _tfTrialExamFormController,
      hintText: _trialExam == null ? LocaleKeys.trialExams_trialExamNameHint.locale() : _trialExam?.examName,
    );
  }

  Widget _trialExamCodeInput() {
    return AppOutlineTextFormField(
      isStyleDifferent: _trialExam == null,
      validateText: LocaleKeys.trialExams_trialExamCodeEmptyAlert.locale(),
      onFieldSubmitted: (value) {
        _saveTrialExam();
      },
      controller: _tfTrialExamCodeFormController,
      hintText: _trialExam == null ? LocaleKeys.trialExams_trialExamCodeHint.locale() : _trialExam?.examCode,
    );
  }

  Widget _title() {
    String title = _trialExam == null
        ? LocaleKeys.trialExams_trialExamFormBoxTitleAdd.locale()
        : LocaleKeys.trialExams_trialExamtFormBoxTitleUpdate.locale();
    return AppMenuTitle(
      title: title,
      color: _trialExam == null ? Colors.amber : infoColor,
    );
  }

  void _saveTrialExam() {
    TrialExamListCubit cubit = context.read<TrialExamListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;

      final TrialExam trialExam = TrialExam(
          examName: _tfTrialExamFormController.text,
          examCode: _tfTrialExamCodeFormController.text,
          classLevel: cubit.selectedCategory,
          examDate: DateTime.now());

      cubit.addTrialExam(trialExam).then((value) {
        _resetForm();
        buttonListener.value = false;
        CustomDialog.showSnackBar(
          message: LocaleKeys.trialExams_trialExamSuccessAdded.locale(),
          context: context,
          type: DialogType.success,
        );
      }, onError: (e) {
        buttonListener.value = false;
        CustomDialog.showSnackBar(
          message: LocaleKeys.alerts_error.locale([e.toString()]),
          context: context,
          type: DialogType.error,
        );
      });
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

  void _editSubject(TrialExam? trialExam) {
    if (trialExam != null) {
      trialExam.examName = _tfTrialExamFormController.text;

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

  bool _checkFormElement() {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
