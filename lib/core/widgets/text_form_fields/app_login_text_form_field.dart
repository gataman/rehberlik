import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rehberlik/common/extensions.dart';

import '../../../common/constants.dart';

class AppLoginTextFormField extends StatelessWidget {
  const AppLoginTextFormField({
    Key? key,
    required this.isSecure,
    required this.validateText,
    this.isEmail,
    this.isNumeric,
    this.onFieldSubmitted,
    this.focusNode,
    this.controller,
    this.hintText,
    this.iconData,
    this.isFinish,
    this.keyboardType,
  }) : super(key: key);
  final bool? isNumeric;
  final bool isSecure;
  final bool? isEmail;
  final bool? isFinish;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String validateText;
  final String? hintText;
  final IconData? iconData;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return validateText;
        } else if (isNumeric != null && isNumeric! && int.tryParse(text) == null) {
          return "Sayısal bir değer girmeniz gerekiyor";
        } else if (isEmail != null && isEmail! && !text.isValidEmail()) {
          return "Geçerli e-posta adresi giriniz!";
        }
        return null;
      },
      keyboardType: keyboardType,
      obscureText: isSecure,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: [
        isEmail != null
            ? AutofillHints.email
            : isSecure
                ? AutofillHints.password
                : AutofillHints.name
      ],
      focusNode: focusNode,
      textInputAction: TextInputAction.go,
      controller: controller,
      style: const TextStyle(color: Colors.amber),
      textAlign: TextAlign.center,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        prefixIcon: iconData != null ? Icon(iconData) : null,
        contentPadding: const EdgeInsets.all(0),
        hintText: hintText,
        errorStyle: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
        isDense: false,
        errorMaxLines: 1,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onEditingComplete: isFinish != null ? (() => TextInput.finishAutofillContext()) : null,
    );
  }
}
