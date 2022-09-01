part of admin_subjects_view;

class SubjectAddFormBox extends StatefulWidget {
  const SubjectAddFormBox({Key? key}) : super(key: key);

  @override
  State<SubjectAddFormBox> createState() => _SubjectAddFormBoxState();
}

class _SubjectAddFormBoxState extends State<SubjectAddFormBox> {
  final _tfSubjectNameFormController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late FocusNode _subjectNameFocusNode;
  Subject? _subject;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

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
        child: BlocBuilder<EditSubjectCubit, EditSubjectState>(
            builder: (context, state) {
          _subject = (state as EditSubjectInitial).editSubject;
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
        }));
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
            text: _subject == null
                ? LocaleKeys.actions_save.locale()
                : LocaleKeys.actions_update.locale(),
            loadingListener: buttonListener,
            onPressed: () {
              if (_subject == null) {
                _saveSubject();
              } else {
                _editSubject(_subject);
              }
            },
            backColor: _subject == null ? Colors.amber : infoColor,
            textColor: secondaryColor,
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
      hintText: _subject == null
          ? LocaleKeys.subjects_subjectNameHint.locale()
          : _subject?.subject,
    );
  }

  Widget _title() {
    String title = _subject == null
        ? LocaleKeys.subjects_subjectFormBoxTitleAdd.locale()
        : LocaleKeys.subjects_subjectFormBoxTitleUpdate.locale();
    return AppBoxTitle(
      title: title,
      color: _subject == null ? Colors.amber : infoColor,
    );
  }

  void _saveSubject() {
    SubjectListCubit cubit = context.read<SubjectListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;
      final params = Get.parameters;
      final Subject subject = Subject(
          lessonID: params['lessonID'],
          subject: _tfSubjectNameFormController.text);

      cubit.addSubject(subject).then((value) {
        _tfSubjectNameFormController.text = "";
        buttonListener.value = false;
        CustomDialog.showSuccessMessage(
            message: LocaleKeys.subjects_subjectSuccessAdded.locale());
      }, onError: (e) {
        buttonListener.value = false;
        CustomDialog.showErrorMessage(
            message: LocaleKeys.alerts_error.locale([e.toString()]));
      });
    }
  }

  void _editSubject(Subject? subject) async {
    SubjectListCubit cubit = context.read<SubjectListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;
      if (subject != null) {
        if (subject.subject == _tfSubjectNameFormController.text) {
          CustomDialog.showWarningMessage(
              message: LocaleKeys.alerts_noChange.locale());
        } else {
          subject.subject = _tfSubjectNameFormController.text;
          cubit.updateSubject(subject).then((value) {
            buttonListener.value = false;
            CustomDialog.showSuccessMessage(
                message: LocaleKeys.subjects_subjectSuccessUpdated.locale());
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
