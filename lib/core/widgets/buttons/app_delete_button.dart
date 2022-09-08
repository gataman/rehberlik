import 'package:flutter/material.dart';

import '../../init/extentions.dart';
import '../../init/locale_keys.g.dart';
import 'app_button_style.dart';

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
