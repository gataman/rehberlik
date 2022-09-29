part of admin_subjects_view;

class SubjectAddFormBox extends StatefulWidget {
  final String lessonID;

  const SubjectAddFormBox({Key? key, required this.lessonID}) : super(key: key);

  @override
  State<SubjectAddFormBox> createState() => _SubjectAddFormBoxState();
}

class _SubjectAddFormBoxState extends State<SubjectAddFormBox> {
  final _tfSubjectNameFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _subjectNameFocusNode;
  late String _lessonID;
  Subject? _subject;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

  @override
  void initState() {
    _lessonID = widget.lessonID;
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
    return Card(
      child: BlocBuilder<EditSubjectCubit, EditSubjectState>(builder: (context, state) {
        _subject = (state as EditSubjectInitial).editSubject;
        if (_subject != null) {
          _subjectNameFocusNode.requestFocus();
          _tfSubjectNameFormController.text = _subject!.subject!;
        } else {
          _tfSubjectNameFormController.text = "";
        }

        return Column(
          children: [
            _title(),
            AppFormBoxElements(formKey: _formKey, children: [
              _subjectNameInput(),
              _actionButtons(),
            ]),
          ],
        );
      }),
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (_subject != null)
          Expanded(
            child: AppCancelFormButton(
              onPressed: () {
                context.read<EditSubjectCubit>().editSubject(null);
              },
            ),
          ),
        if (_subject != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: LoadingButton(
            text: _subject == null ? LocaleKeys.actions_save.locale() : LocaleKeys.actions_update.locale(),
            loadingListener: buttonListener,
            onPressed: () {
              if (_subject == null) {
                _saveSubject();
              } else {
                _editSubject(_subject);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _subjectNameInput() {
    return AppOutlineTextFormField(
      isStyleDifferent: _subject == null,
      validateText: LocaleKeys.lessons_lessonNameEmptyAlert.locale(),
      onFieldSubmitted: (value) {
        _saveSubject();
      },
      focusNode: _subjectNameFocusNode,
      controller: _tfSubjectNameFormController,
      hintText: _subject == null ? LocaleKeys.subjects_subjectNameHint.locale() : _subject?.subject,
    );
  }

  Widget _title() {
    String title = _subject == null
        ? LocaleKeys.subjects_subjectFormBoxTitleAdd.locale()
        : LocaleKeys.subjects_subjectFormBoxTitleUpdate.locale();
    return AppMenuTitle(
      title: title,
      color: _subject == null ? Colors.amber : infoColor,
    );
  }

  void _saveSubject() {
    SubjectListCubit cubit = context.read<SubjectListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;
      final Subject subject = Subject(lessonID: _lessonID, subject: _tfSubjectNameFormController.text);

      cubit.addSubject(subject).then((value) {
        _tfSubjectNameFormController.text = "";
        buttonListener.value = false;
        CustomDialog.showSnackBar(
          message: LocaleKeys.subjects_subjectSuccessAdded.locale(),
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

  void _editSubject(Subject? subject) async {
    SubjectListCubit cubit = context.read<SubjectListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;
      if (subject != null) {
        if (subject.subject == _tfSubjectNameFormController.text) {
          CustomDialog.showSnackBar(
            message: LocaleKeys.alerts_noChange.locale(),
            context: context,
            type: DialogType.warning,
          );
        } else {
          subject.subject = _tfSubjectNameFormController.text;
          cubit.updateSubject(subject).then((value) {
            buttonListener.value = false;
            CustomDialog.showSnackBar(
              message: LocaleKeys.subjects_subjectSuccessUpdated.locale(),
              context: context,
              type: DialogType.success,
            );
            _tfSubjectNameFormController.text = "";
            context.read<EditSubjectCubit>().editSubject(null);
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
