import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/extensions.dart';

class AppLoginTextFormField extends StatelessWidget {
  const AppLoginTextFormField(
      {Key? key,
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
      this.autofillHints,
      this.inputFormatters})
      : super(key: key);
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
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;

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
      autofillHints: autofillHints,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.go,
      controller: controller,
      textAlign: TextAlign.center,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        prefixIcon: iconData != null ? Icon(iconData) : null,
        contentPadding: const EdgeInsets.all(0),
        hintText: hintText,
        errorStyle: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
        isDense: false,
        errorMaxLines: 1,
      ),
      onEditingComplete: isFinish != null ? (() => TextInput.finishAutofillContext()) : null,
    );
  }
}
