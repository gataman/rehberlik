import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/buttons/app_button_style.dart';

class AppCancelDeleteButton extends StatelessWidget {
  const AppCancelDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: infoColor),
      onPressed: () => Get.back(),
      label: Text(LocaleKeys.actions_cancel.locale()),
      icon: AppButtonStyle.icCancel,
    );
  }
}
