import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/custom_dialog.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_login_text_form_field.dart';
import 'package:rehberlik/views/auth/cubit/auth_cubit.dart';

import '../../../common/constants.dart';
import '../../../common/navigaton/app_router/app_routes.dart';
import '../../../common/widgets/loading_button.dart';
import '../../../core/init/locale_manager.dart';
import '../../../core/init/pref_keys.dart';
import '../../../core/widgets/containers/app_form_box_elements.dart';

class TeacherLoginView extends StatefulWidget {
  const TeacherLoginView({Key? key}) : super(key: key);

  @override
  State<TeacherLoginView> createState() => _TeacherLoginViewState();
}

class _TeacherLoginViewState extends State<TeacherLoginView> {
  late GlobalKey<FormState> _formKey;
  late FocusNode _teacherEmailFocusNode;
  late FocusNode _teacherPasswordFocusNode;
  late TextEditingController _tfTeacherEmailController;
  late TextEditingController _tfTeacherPasswordController;
  late ValueNotifier<bool> _buttonListener;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _teacherEmailFocusNode = FocusNode();
    _teacherPasswordFocusNode = FocusNode();
    _tfTeacherEmailController = TextEditingController();
    _tfTeacherPasswordController = TextEditingController();
    _buttonListener = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: AppFormBoxElements(formKey: _formKey, children: [
        const SizedBox(
          height: defaultPadding,
        ),
        _teacherEmailInput(),
        _teacherPasswordInput(),
        _loginButton(),
      ]),
    );
  }

  Widget _teacherEmailInput() {
    return AppLoginTextFormField(
      iconData: Icons.person,
      validateText: 'E-posta adresi boş olamaz',
      isSecure: false,
      isEmail: true,
      onFieldSubmitted: (value) {
        _login();
      },
      focusNode: _teacherEmailFocusNode,
      controller: _tfTeacherEmailController,
      hintText: 'E-Posta Adresi',
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _teacherPasswordInput() {
    return AppLoginTextFormField(
      iconData: Icons.password,
      validateText: 'Şifre boş olamaz',
      isSecure: true,
      isFinish: true,
      onFieldSubmitted: (value) {
        _login();
      },
      focusNode: _teacherPasswordFocusNode,
      controller: _tfTeacherPasswordController,
      hintText: 'Şifre',
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _loginButton() {
    return LoadingButton(
      text: 'Giriş',
      loadingListener: _buttonListener,
      iconData: Icons.login,
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

      try {
        final credential = await context
            .read<AuthCubit>()
            .teacherLogin(email: _tfTeacherEmailController.text, password: _tfTeacherPasswordController.text);
        _buttonListener.value = false;
        await SharedPrefs.instance.setString(PrefKeys.userID.toString(), credential.user!.uid);
        await SharedPrefs.instance.setInt(PrefKeys.userType.toString(), 1);
        CustomDialog.showSnackBar(
            context: context,
            message: 'Başarıyla giriş yapıldı! Yönlendiriliyorsunuz...',
            type: DialogType.success,
            duration: const Duration(seconds: 1));
        await Future.delayed(const Duration(seconds: 1));
        context.router.replaceNamed(AppRoutes.routeMainAdmin);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _buttonListener.value = false;

          CustomDialog.showSnackBar(
              context: context, message: 'Bu e-posta adresine kayıtlı kullanıcı bulunamadı', type: DialogType.error);
        } else if (e.code == 'wrong-password') {
          _buttonListener.value = false;

          CustomDialog.showSnackBar(
              context: context, message: 'Şifre yanlış lütfen kontrol edin!', type: DialogType.error);
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
