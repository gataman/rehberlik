import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../init/extentions.dart';
import '../../init/locale_keys.g.dart';
import 'app_button_style.dart';

class AppCancelDeleteButton extends StatelessWidget {
  const AppCancelDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: infoColor),
      onPressed: () => Navigator.pop(context),
      label: Text(LocaleKeys.actions_cancel.locale()),
      icon: AppButtonStyle.icCancel,
    );
  }
}
