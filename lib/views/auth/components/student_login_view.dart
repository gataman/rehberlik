import 'package:flutter/material.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_login_text_form_field.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/loading_button.dart';
import '../../../core/widgets/containers/app_form_box_elements.dart';

class StudentLoginView extends StatefulWidget {
  const StudentLoginView({Key? key}) : super(key: key);

  @override
  State<StudentLoginView> createState() => _StudentLoginViewState();
}

class _StudentLoginViewState extends State<StudentLoginView> {
  late GlobalKey<FormState> _formKey;
  late FocusNode _studentNumberFocusNode;
  late FocusNode _studentPasswordFocusNode;
  late TextEditingController _tfStudentNumberController;
  late TextEditingController _tfStudentPasswordController;
  late ValueNotifier<bool> _buttonListener;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _studentNumberFocusNode = FocusNode();
    _studentPasswordFocusNode = FocusNode();
    _tfStudentNumberController = TextEditingController();
    _tfStudentPasswordController = TextEditingController();
    _buttonListener = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppFormBoxElements(formKey: _formKey, children: [
      const SizedBox(
        height: defaultPadding,
      ),
      _studentNumberInput(),
      _studentPasswordInput(),
      _loginButton(),
    ]);
  }

  Widget _studentNumberInput() {
    return AppLoginTextFormField(
      iconData: Icons.person,
      validateText: 'Öğrenci Numarası boş olamaz',
      isSecure: false,
      isNumeric: true,
      onFieldSubmitted: (value) {},
      focusNode: _studentNumberFocusNode,
      controller: _tfStudentNumberController,
      hintText: 'Öğrenci Numarası',
      keyboardType: TextInputType.number,
    );
  }

  Widget _studentPasswordInput() {
    return AppLoginTextFormField(
      iconData: Icons.password,
      validateText: 'Şifre boş olamaz',
      isSecure: true,
      onFieldSubmitted: (value) {},
      focusNode: _studentPasswordFocusNode,
      controller: _tfStudentPasswordController,
      hintText: 'Şifre',
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _loginButton() {
    return LoadingButton(
      text: 'Giriş',
      iconData: Icons.login,
      loadingListener: _buttonListener,
      onPressed: () {
        _login();
      },
      backColor: Colors.amber,
      textColor: darkSecondaryColor,
    );
  }

  void _login() async {
    if (!_buttonListener.value && _checkFormElement()) {
      _buttonListener.value = true;

      await Future.delayed(const Duration(seconds: 3));
      _buttonListener.value = false;
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
