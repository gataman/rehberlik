import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ga_uikit/ga_uikit.dart';
import '../../../../../common/constants.dart';
import '../../../../../common/helper.dart';
import '../../../../../models/student.dart';

import '../../../../../core/validator_helper.dart';
import '../../../../../models/classes.dart';
import '../../../admin_classes/components/class_list_card/cubit/class_list_cubit.dart';

class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({Key? key, required this.classes}) : super(key: key);
  final Classes classes;

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  late final ValueNotifier<bool> _loadingListener;
  late final ValueNotifier<String?> _errorListener;
  late final TextEditingController _studentNameController;
  late final TextEditingController _studentNumberController;
  late final TextEditingController _fatherNameController;
  late final TextEditingController _motherNameController;
  late final TextEditingController _fatherPhoneController;
  late final TextEditingController _motherPhoneController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _loadingListener = ValueNotifier(false);
    _errorListener = ValueNotifier(null);
    _studentNameController = TextEditingController();
    _studentNumberController = TextEditingController();
    _fatherNameController = TextEditingController();
    _motherNameController = TextEditingController();
    _fatherPhoneController = TextEditingController();
    _motherPhoneController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordController.text = Helper.getRandomString(6);
    super.initState();
  }

  @override
  void dispose() {
    _loadingListener.dispose();
    _errorListener.dispose();
    _studentNameController.dispose();
    _studentNumberController.dispose();
    _fatherNameController.dispose();
    _motherNameController.dispose();
    _fatherPhoneController.dispose();
    _motherPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GaFormDialog(
      buildContent: (context) {
        return GaFormDialogContent(
          content: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Form(
                key: _formKey,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    _studentNameField,
                    _studentNumberField,
                    _getDivider(context),
                    _motherNameField,
                    _fatherNameField,
                    _motherPhoneField,
                    _fatherPhoneField,
                    _passwordField,
                    Text(
                      '  * Şifre sistem tarafından oluşturuldu. Dilerseniz değiştirebilirsiniz',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).colorScheme.primary, fontStyle: FontStyle.italic),
                    )
                  ],
                )),
          ),
          title: '${widget.classes.className} Sınıfına Öğrenci Ekle',
          confirmButtonColor: Theme.of(context).primaryColor,
          onConfirmButtonPressed: () {
            _saveStudent(context);
          },
          confirmIconPosition: IconPosition.left,
          confirmButtonRoundType: RadiusType.bottom,
          confirmButtonLabel: 'Kaydet',
          loadingListener: _loadingListener,
          loadingText: 'Öğrenci kaydediliyor! Lütfen bekleyin...',
          errorListener: _errorListener,
        );
      },
    );
  }

  GaTextFormField get _studentNameField => GaTextFormField(
        controller: _studentNameController,
        label: 'Adı Soyadı',
        textInputAction: TextInputAction.next,
        autoFocus: true,
        validator: (value) {
          return ValidatorHelper.emptyValidator(
            value: value,
            message: 'Öğrenci Adı boş olamaz!',
          );
        },
      );

  GaTextFormField get _studentNumberField => GaTextFormField(
        controller: _studentNumberController,
        keyboardType: TextInputType.number,
        label: 'Öğrenci No',
        textInputAction: TextInputAction.next,
        validator: (value) {
          return ValidatorHelper.emptyNumericValidator(
            value: value,
            message: 'Öğrenci No boş olamaz!',
          );
        },
      );

  GaTextFormField get _motherNameField => GaTextFormField(
        controller: _motherNameController,
        label: 'Anne Adı',
        textInputAction: TextInputAction.next,
      );

  GaTextFormField get _fatherNameField => GaTextFormField(
        controller: _fatherNameController,
        label: 'Baba Adı',
        textInputAction: TextInputAction.next,
      );

  GaTextFormField get _motherPhoneField => GaTextFormField(
        controller: _motherPhoneController,
        label: 'Anne Telefon No',
        textInputAction: TextInputAction.next,
      );
  GaTextFormField get _fatherPhoneField => GaTextFormField(
        controller: _fatherPhoneController,
        label: 'Baba Telefon No',
        textInputAction: TextInputAction.next,
      );

  Widget _getDivider(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            '* İsteğe Bağlı Alanlar:',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ],
      );

  GaTextFormField get _passwordField => GaTextFormField(
        controller: _passwordController,
        label: 'Şifre',
        textInputAction: TextInputAction.next,
      );

  void _saveStudent(BuildContext context) async {
    _loadingListener.value = true;
    if (_formKey.currentState!.validate()) {
      var studentName = _studentNameController.text;
      var studentNumber = _studentNumberController.text;
      var fatherName = _fatherNameController.text.isNotEmpty ? _fatherNameController.text : null;
      var motherName = _motherNameController.text.isNotEmpty ? _motherNameController.text : null;
      var fatherPhone = _fatherPhoneController.text.isNotEmpty ? _fatherPhoneController.text : null;
      var motherPhone = _motherPhoneController.text.isNotEmpty ? _motherPhoneController.text : null;
      var password = _passwordController.text.isNotEmpty ? _passwordController.text : null;

      final student = Student(
          studentName: studentName,
          studentNumber: studentNumber,
          fatherName: fatherName,
          motherName: motherName,
          fatherPhone: fatherPhone,
          motherPhone: motherPhone,
          classID: widget.classes.id,
          className: widget.classes.className,
          classLevel: widget.classes.classLevel,
          password: password);

      final result = await context.read<ClassListCubit>().addStudent(student);

      if (mounted) {
        GaStaticDialogs.showSnackBar(context: context, message: 'Öğrenci başarıyla eklendi', type: DialogType.success);
        Navigator.pop(context);
      }
    } else {
      _loadingListener.value = false;
    }
  }
}
