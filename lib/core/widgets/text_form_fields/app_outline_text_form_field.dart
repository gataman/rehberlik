import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';

class AppOutlineTextFormField extends StatelessWidget {
  const AppOutlineTextFormField(
      {Key? key,
      this.isNumeric,
      this.onFieldSubmitted,
      this.focusNode,
      this.controller,
      required this.isStyleDifferent,
      required this.validateText,
      this.hintText})
      : super(key: key);

  final bool? isNumeric;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool isStyleDifferent;
  final String validateText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return validateText;
        } else if (isNumeric != null &&
            isNumeric! &&
            int.tryParse(text) == null) {
          return "Sayısal bir değer girmeniz gerekiyor";
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      textInputAction: TextInputAction.go,
      controller: controller,
      style: TextStyle(color: isStyleDifferent ? Colors.amber : infoColor),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
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
    );
  }
}
