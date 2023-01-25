import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_login_text_form_field.dart';
import 'package:rehberlik/views/auth/cubit/auth_cubit.dart';

import '../../../common/constants.dart';
import '../../../common/enums/user_type.dart';
import '../../../common/navigaton/app_router/app_routes.dart';
import '../../../common/widgets/loading_button.dart';
import '../../../core/init/locale_manager.dart';
import '../../../core/init/pref_keys.dart';
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
    //_tfStudentNumberController.text = '171';
    return AppLoginTextFormField(
      iconData: Icons.person,
      validateText: 'Öğrenci Numarası boş olamaz',
      isSecure: false,
      isNumeric: true,
      focusNode: _studentNumberFocusNode,
      controller: _tfStudentNumberController,
      hintText: 'Öğrenci Numarası',
      autofillHints: const [AutofillHints.username],
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );
  }

  Widget _studentPasswordInput() {
    //_tfStudentPasswordController.text = 'TLZDF8';
    return AppLoginTextFormField(
      iconData: Icons.password,
      validateText: 'Şifre boş olamaz',
      isSecure: true,
      autofillHints: const [AutofillHints.password],
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
    );
  }

  void _login() async {
    if (!_buttonListener.value && _checkFormElement()) {
      _buttonListener.value = true;

      final number = _tfStudentNumberController.text;
      final password = _tfStudentPasswordController.text;

      context.read<AuthCubit>().studentLogin(number: number, password: password).then((result) async {
        _buttonListener.value = false;
        if (result.isSuccess) {
          await SharedPrefs.instance.setString(PrefKeys.userID.toString(), result.student!.id!);
          await SharedPrefs.instance.setInt(PrefKeys.userType.toString(), UserType.student.type);
          await SharedPrefs.instance.setString(PrefKeys.student.toString(), json.encode(result.student));

          CustomDialog.showSnackBar(
              context: context, message: 'Başarıyla giriş yapıldı! Yönlendiriliyorsunuz...', type: DialogType.success);
          await Future.delayed(const Duration(seconds: 1));
          context.router.replaceNamed(AppRoutes.routeMainStudent);
        } else {
          CustomDialog.showSnackBar(context: context, message: result.message, type: DialogType.error);
        }
      });
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
