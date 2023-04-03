part of admin_trial_exam_view;

class TrialExamAddFormBox extends StatefulWidget {
  const TrialExamAddFormBox({Key? key, required this.teacherType}) : super(key: key);
  final TeacherType teacherType;

  @override
  State<TrialExamAddFormBox> createState() => _TrialExamAddFormBoxState();
}

class _TrialExamAddFormBoxState extends State<TrialExamAddFormBox> {
  final _tfTrialExamFormController = TextEditingController();
  final _tfTrialExamCodeFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _trialExamNameFocusNode;
  late FocusNode _trialExamCodeFocusNode;
  TrialExam? _trialExam;
  int _selectedIndex = 3;
  int? _selectedTrialExamType;
  DateTime? _dateTime;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

  @override
  void initState() {
    _trialExamNameFocusNode = FocusNode();
    _trialExamCodeFocusNode = FocusNode();
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
    debugPrint('Build.......');

    return Card(
      child: BlocBuilder<TrialExamFormBoxCubit, TrialExamFormBoxState>(builder: (context, state) {
        _trialExam = state is EditTrialExamState ? state.editTrialExam : null;

        if (_trialExam != null) {
          _trialExamNameFocusNode.requestFocus();
          _tfTrialExamFormController.text = _trialExam!.examName!;
          _tfTrialExamCodeFormController.text = _trialExam!.examCode!;
          _dateTime = _trialExam!.examDate;
          _selectedTrialExamType = _trialExam!.examType;
        } else {
          debugPrint('----------------');
          debugPrint('elseeee');
          _resetForm();
        }

        debugPrint('..... ${_dateTime?.day.toString()}');

        return Column(
          children: [
            _title(),
            AppFormBoxElements(formKey: _formKey, children: [
              ClassesLevelSelectBox(
                valueChanged: (index) {
                  debugPrint('ClassesLevelSelectBox ......');
                  context.read<TrialExamListCubit>().changeCategory(index + 5);
                  context.read<TrialExamFormBoxCubit>().editTrialExam(trialExam: null);
                },
                selectedIndex: _selectedIndex,
              ),
              if (widget.teacherType == TeacherType.admin)
                TrialExamTypeSelectBox(
                  valueChanged: (value) {
                    _selectedTrialExamType = value;
                  },
                  typeIndex: _selectedTrialExamType,
                ),
              if (widget.teacherType == TeacherType.admin) _trialExamNameInput(),
              if (widget.teacherType == TeacherType.admin) _trialExamCodeInput(),
              if (widget.teacherType == TeacherType.admin)
                AppDatePickerText(
                  initialValue: _dateTime,
                  valueChanged: (value) {
                    _dateTime = value;
                  },
                ),
              if (widget.teacherType == TeacherType.admin) _actionButtons(),
            ]),
          ],
        );
      }),
    );
  }

  void _resetForm() {
    _tfTrialExamFormController.text = "";
    _tfTrialExamCodeFormController.text = "";
    _dateTime = null;
    _selectedTrialExamType = null;
    debugPrint('_resetForm ......');
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
        debugPrint('denemee');
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
      focusNode: _trialExamCodeFocusNode,
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
      if (_selectedTrialExamType == null) {
        CustomDialog.showSnackBar(context: context, message: 'Sınav tipini seçiniz!', type: DialogType.error);
      } else if (_dateTime == null) {
        CustomDialog.showSnackBar(context: context, message: 'Sınav tarihini seçiniz!', type: DialogType.error);
      } else {
        buttonListener.value = true;

        final TrialExam trialExam = TrialExam(
            examName: _tfTrialExamFormController.text,
            examCode: _tfTrialExamCodeFormController.text,
            classLevel: cubit.selectedCategory,
            examDate: _dateTime,
            examType: _selectedTrialExamType!);

        cubit.addTrialExam(trialExam).then((value) {
          context.read<TrialExamFormBoxCubit>().editTrialExam(trialExam: null);
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
    }
  }

  void _editSubject(TrialExam? trialExam) {
    if (trialExam != null) {
      TrialExamListCubit cubit = context.read<TrialExamListCubit>();
      if (!buttonListener.value && _checkFormElement()) {
        if (_selectedTrialExamType == null) {
          CustomDialog.showSnackBar(context: context, message: 'Sınav tipini seçiniz!', type: DialogType.error);
        } else if (_dateTime == null) {
          CustomDialog.showSnackBar(context: context, message: 'Sınav tarihini seçiniz!', type: DialogType.error);
        } else {
          buttonListener.value = true;

          trialExam.examName = _tfTrialExamFormController.text;
          trialExam.examCode = _tfTrialExamCodeFormController.text;
          trialExam.classLevel = cubit.selectedCategory;
          trialExam.examDate = _dateTime;
          trialExam.examType = _selectedTrialExamType!;

          cubit.updateTrialExam(trialExam).then((value) {
            context.read<TrialExamFormBoxCubit>().editTrialExam(trialExam: null);
            buttonListener.value = false;
            CustomDialog.showSnackBar(
              message: LocaleKeys.trialExams_trialExamSuccessUpdated.locale(),
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
      }
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
