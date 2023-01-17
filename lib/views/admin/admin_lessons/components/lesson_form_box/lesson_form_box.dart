part of admin_lessons_view;

class LessonFormBox extends StatefulWidget {
  const LessonFormBox({Key? key}) : super(key: key);

  @override
  State<LessonFormBox> createState() => _LessonFormBoxState();
}

class _LessonFormBoxState extends State<LessonFormBox> {
  final _tfLessonNameFormController = TextEditingController();
  final _tfLessonTimeFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _lessonNameFocusNode;
  Lesson? _lesson;
  int _selectedIndex = 3;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

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
    _selectedIndex = context.read<LessonListCubit>().selectedCategory - 5;
    return Card(
      child: BlocBuilder<LessonFormBoxCubit, LessonFormBoxState>(
        builder: (context, state) {
          _lesson = state is EditLessonState ? state.editLesson : null;
          if (_lesson != null) {
            _lessonNameFocusNode.requestFocus();
            _tfLessonNameFormController.text = _lesson!.lessonName!;
            _tfLessonTimeFormController.text = _lesson!.lessonTime!.toString();
          } else {
            _clearForm();
          }

          return Column(
            children: [
              _title(),
              AppFormBoxElements(formKey: _formKey, children: [
                ClassesLevelSelectBox(
                  valueChanged: (index) {
                    context.read<LessonListCubit>().changeCategory(index + 5);
                  },
                  selectedIndex: _selectedIndex,
                ),
                _lessonNameInput(),
                _lessonTimeInput(),
                _actionButtons(),
              ]),
            ],
          );
        },
      ),
    );
  }

  /*
    
  */

  void _clearForm() {
    _tfLessonNameFormController.text = "";
    _tfLessonTimeFormController.text = "";
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (_lesson != null)
          Expanded(
            child: AppCancelFormButton(
              onPressed: () {
                context.read<LessonFormBoxCubit>().editLesson(lesson: null);
              },
            ),
          ),
        if (_lesson != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: LoadingButton(
            text: _lesson == null ? LocaleKeys.actions_save.locale() : LocaleKeys.actions_update.locale(),
            loadingListener: buttonListener,
            onPressed: () {
              if (_lesson == null) {
                _saveLesson();
              } else {
                _editLesson(_lesson);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _lessonNameInput() {
    return AppOutlineTextFormField(
      isStyleDifferent: _lesson == null,
      validateText: LocaleKeys.lessons_lessonNameEmptyAlert.locale(),
      onFieldSubmitted: (value) {
        _saveLesson();
      },
      focusNode: _lessonNameFocusNode,
      controller: _tfLessonNameFormController,
      hintText: _lesson == null ? LocaleKeys.lessons_lessonNameHint.locale() : _lesson!.lessonName ?? '',
    );
  }

  Widget _lessonTimeInput() {
    return AppOutlineTextFormField(
      isStyleDifferent: _lesson == null,
      validateText: LocaleKeys.lessons_lessonTimeEmptyAlert.locale(),
      isNumeric: true,
      onFieldSubmitted: (value) {
        _saveLesson();
      },
      controller: _tfLessonTimeFormController,
      hintText: _lesson == null ? LocaleKeys.lessons_lessonTimeHint.locale() : _lesson?.lessonTime.toString(),
    );
  }

  Widget _title() {
    String title = _lesson == null
        ? LocaleKeys.lessons_lessonFormBoxTitleAdd.locale()
        : LocaleKeys.lessons_lessonFormBoxTitleUpdate.locale();

    return AppMenuTitle(
      title: title,
      color: _lesson == null ? Colors.amber : infoColor,
    );
  }

  void _saveLesson() {
    if (!buttonListener.value && _checkFormElement()) {
      LessonListCubit cubit = context.read<LessonListCubit>();
      buttonListener.value = true;

      final Lesson lesson = Lesson(
          schoolID: "w7WZvgcVPKVheXnhxMHE",
          lessonName: _tfLessonNameFormController.text,
          classLevel: cubit.selectedCategory,
          lessonTime: int.parse(_tfLessonTimeFormController.text));

      final LessonWithSubject lessonWithSubject = LessonWithSubject(lesson: lesson);

      cubit.addLesson(lessonWithSubject).then((value) {
        buttonListener.value = false;
        _clearForm();
        CustomDialog.showSnackBar(
          message: LocaleKeys.lessons_lessonSuccessAdded.locale(),
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

  void _editLesson(Lesson? lesson) {
    LessonListCubit cubit = context.read<LessonListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;
      if (lesson != null) {
        if (lesson.lessonName == _tfLessonNameFormController.text &&
            lesson.classLevel == cubit.selectedCategory &&
            lesson.lessonTime.toString() == _tfLessonTimeFormController.text) {
          CustomDialog.showSnackBar(
            message: LocaleKeys.alerts_noChange.locale(),
            context: context,
            type: DialogType.warning,
          );
          buttonListener.value = false;
        } else {
          lesson.lessonName = _tfLessonNameFormController.text;
          //final lessonTime = int.tryParse( _tfLessonTimeFormController.text);
          lesson.lessonTime = int.parse(_tfLessonTimeFormController.text);
          var oldClass = lesson.classLevel;
          lesson.classLevel = cubit.selectedCategory;
          cubit.updateLesson(lesson, oldClass!).then((value) {
            buttonListener.value = false;
            CustomDialog.showSnackBar(
              message: LocaleKeys.lessons_lessonSuccessUpdated.locale(),
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
