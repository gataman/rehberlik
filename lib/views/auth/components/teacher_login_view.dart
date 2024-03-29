import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/custom_dialog.dart';
import '../../../core/widgets/text_form_fields/app_login_text_form_field.dart';
import '../../../models/teacher.dart';
import '../cubit/auth_cubit.dart';

import '../../../common/constants.dart';
import '../../../common/enums/user_type.dart';
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
    // _tfTeacherEmailController.text = 'gurcanataman@gmail.com';
    return AppLoginTextFormField(
      iconData: Icons.person,
      validateText: 'E-posta adresi boş olamaz',
      isSecure: false,
      isEmail: true,
      autofillHints: const [AutofillHints.email],
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
    //_tfTeacherPasswordController.text = '112233i_';
    return AppLoginTextFormField(
      iconData: Icons.password,
      validateText: 'Şifre boş olamaz',
      isSecure: true,
      isFinish: true,
      autofillHints: const [AutofillHints.password],
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
    );
  }

  void _login() async {
    if (!_buttonListener.value && _checkFormElement()) {
      _buttonListener.value = true;
      final result = await context
          .read<AuthCubit>()
          .teacherLogin(email: _tfTeacherEmailController.text, password: _tfTeacherPasswordController.text);
      _buttonListener.value = false;

      if (result.isSuccess) {
        await SharedPrefs.instance.setString(PrefKeys.userID.toString(), result.teacher!.id!);
        await SharedPrefs.instance.setInt(PrefKeys.userType.toString(), UserType.teacher.type);
        await SharedPrefs.instance.setString(PrefKeys.teacher.toString(), json.encode(result.teacher));

        CustomDialog.showSnackBar(
            context: context, message: 'Başarıyla giriş yapıldı! Yönlendiriliyorsunuz...', type: DialogType.success);
        await Future.delayed(const Duration(seconds: 1));
        debugPrint(result.teacher!.rank.toString());
        if (result.teacher!.rank == TeacherType.admin.type) {
          context.router.replaceNamed(AppRoutes.routeMainAdmin);
        } else {
          context.router.replaceNamed(AppRoutes.routeMainTeacher);
        }
      } else {
        CustomDialog.showSnackBar(context: context, message: result.message, type: DialogType.error);
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
