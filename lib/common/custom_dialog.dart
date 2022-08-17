import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/common/constants.dart';

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
    Get.snackbar(
      "Hata",
      message,
      colorText: secondaryColor,
      backgroundColor: Colors.redAccent,
    );
  }

  static void showWarningMessage({required String message}) {
    Get.snackbar(
      "Uyarı",
      message,
      colorText: secondaryColor,
      backgroundColor: Colors.amber,
    );
  }
}
