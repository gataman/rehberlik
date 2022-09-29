part of admin_classes_view;

class ClassFormBox extends StatefulWidget {
  const ClassFormBox({Key? key}) : super(key: key);

  @override
  State<ClassFormBox> createState() => _ClassFormBoxState();
}

class _ClassFormBoxState extends State<ClassFormBox> {
  final _formKey = GlobalKey<FormState>();
  final _tfClassNameFormController = TextEditingController();
  late FocusNode _classNameFocusNode;
  Classes? _classes;
  final ValueNotifier<bool> buttonListener = ValueNotifier(false);

  //final _box = GetStorage();
  int _selectedIndex = 0;

  @override
  void initState() {
    _classNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tfClassNameFormController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<ClassFormBoxCubit, ClassFormBoxState>(
        builder: (context, state) {
          _classes = state is EditClassState ? state.editedClass : null;
          if (_classes != null) {
            _selectedIndex = _classes!.classLevel! - 5;
            _classNameFocusNode.requestFocus();
            _tfClassNameFormController.text = _classes!.className ?? "";
          } else {
            _tfClassNameFormController.text = "";
          }

          return Column(
            children: [
              _title(),
              AppFormBoxElements(formKey: _formKey, children: [
                ClassesLevelSelectBox(
                  valueChanged: (index) {
                    _selectedIndex = index;
                  },
                  selectedIndex: _selectedIndex,
                ),
                _classNameInput(),
                _actionButtons(),
              ]),
            ],
          );
        },
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      children: [
        // Cancel Button
        if (_classes != null)
          Expanded(
            child: AppCancelFormButton(
              onPressed: () {
                context.read<ClassFormBoxCubit>().editClass(classes: null);
              },
            ),
          ),
        if (_classes != null)
          const SizedBox(
            width: defaultPadding / 2,
          ),
        Expanded(
          child: LoadingButton(
            text: _classes == null ? LocaleKeys.actions_save.locale() : LocaleKeys.actions_update.locale(),
            loadingListener: buttonListener,
            onPressed: () {
              if (_classes == null) {
                _saveClass();
              } else {
                _editClasses(_classes);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _classNameInput() {
    return AppOutlineTextFormField(
        isStyleDifferent: _classes == null,
        validateText: LocaleKeys.classes_classNameEmptyAlert.locale(),
        onFieldSubmitted: (value) {
          _saveClass();
        },
        focusNode: _classNameFocusNode,
        controller: _tfClassNameFormController,
        hintText: _classes == null ? LocaleKeys.classes_classNameHint.locale() : _classes!.className ?? '');
  }

  Widget _title() {
    String title = _classes == null
        ? LocaleKeys.classes_classFormBoxTitleAdd.locale()
        : LocaleKeys.classes_classFormBoxTitleUpdate.locale();

    return AppMenuTitle(
      title: title,
      color: _classes == null ? Colors.amber : infoColor,
    );
  }

  void _saveClass() {
    if (!buttonListener.value && _checkFormElement()) {
      ClassListCubit cubit = context.read<ClassListCubit>();
      buttonListener.value = true;
      final schoolID = SharedPrefs.instance.getString(PrefKeys.schoolID.toString()); //_box.read("schoolID");

      final Classes classes =
          Classes(schoolID: schoolID, className: _tfClassNameFormController.text, classLevel: _selectedIndex + 5);

      cubit.addClass(classes).then((value) {
        buttonListener.value = false;
        _tfClassNameFormController.text = "";
        CustomDialog.showSnackBar(
          message: LocaleKeys.classes_classSuccessAdded.locale(),
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

  void _editClasses(Classes? classes) {
    ClassListCubit cubit = context.read<ClassListCubit>();
    if (!buttonListener.value && _checkFormElement()) {
      buttonListener.value = true;
      if (classes != null) {
        if (classes.className == _tfClassNameFormController.text && classes.classLevel == _selectedIndex + 5) {
          CustomDialog.showSnackBar(
            message: LocaleKeys.alerts_noChange.locale(),
            context: context,
            type: DialogType.warning,
          );
          buttonListener.value = false;
        } else {
          classes.className = _tfClassNameFormController.text;
          //final lessonTime = int.tryParse( _tfLessonTimeFormController.text);
          classes.classLevel = _selectedIndex + 5;
          cubit.updateClasses(classes).then((value) {
            buttonListener.value = false;
            CustomDialog.showSnackBar(
              message: LocaleKeys.classes_classSuccessUpdated.locale(),
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

    /*
    if (classes != null) {
      if (controller.tfAddFormController.text.trim().isEmpty) {
        debugPrint("Boşşş");
      } else {
        classes.className = controller.tfAddFormController.text;
        classes.classLevel = controller.selectedClassesCategory.value;
        controller.updateClasses(classes);
        Get.snackbar(
          "Başarılı",
          "Sınıf adı başarıyla güncellendi",
          duration: const Duration(seconds: 2),
          colorText: secondaryColor,
          backgroundColor: infoColor,
        );
      }
    }

     */
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
