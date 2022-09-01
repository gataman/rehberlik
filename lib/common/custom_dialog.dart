import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/core/init/extentions.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';
import 'package:rehberlik/core/widgets/buttons/app_cancel_delete_button.dart';
import 'package:rehberlik/core/widgets/buttons/app_delete_button.dart';

class CustomDialog {
  static void showSuccessMessage({required String message}) {
    Get.snackbar(
      "Başarılı",
      message,
      colorText: secondaryColor,
      backgroundColor: Colors.teal,
    );
  }

  static void showErrorMessage({required String message}) {
    Get.snackbar("Hata", message,
        colorText: secondaryColor,
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 4));
  }

  static void showWarningMessage({required String message}) {
    Get.snackbar(
      "Uyarı",
      message,
      colorText: secondaryColor,
      backgroundColor: Colors.amber,
    );
  }

  static void showDeleteAlertDialog(
      {required String message, required VoidCallback onConfirm}) {
    Get.defaultDialog(
        title: LocaleKeys.actions_warning.locale(),
        titleStyle: const TextStyle(
          color: primaryColor,
        ),
        contentPadding: const EdgeInsets.all(defaultPadding),
        backgroundColor: Colors.white,
        middleText: message,
        middleTextStyle: const TextStyle(
          color: bgColor,
        ),
        actions: [
          const AppCancelDeleteButton(),
          AppDeleteButton(onConfirm: onConfirm)
        ]
        //onConfirm: onConfirm,
        //onCancel: () => Get.back(),
        //textConfirm: LocaleKeys.actions_delete.locale(),
        //confirmTextColor: secondaryColor,
        //textCancel: LocaleKeys.actions_cancel.locale(),
        );
  }
}
