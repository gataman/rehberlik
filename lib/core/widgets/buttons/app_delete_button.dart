import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/buttons/app_button_style.dart';

class AppDeleteButton extends StatelessWidget {
  const AppDeleteButton({Key? key, required this.onConfirm}) : super(key: key);

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: AppButtonStyle.deleteButtonStyle,
      onPressed: onConfirm,
      label: Text(LocaleKeys.actions_delete.locale()),
      icon: AppButtonStyle.icDelete,
    );
  }
}
