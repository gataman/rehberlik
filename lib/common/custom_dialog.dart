import 'package:flutter/material.dart';
import 'constants.dart';
import '../core/init/extentions.dart';
import '../core/init/locale_keys.g.dart';
import '../core/widgets/buttons/app_cancel_delete_button.dart';
import '../core/widgets/buttons/app_delete_button.dart';

enum DialogType { success, warning, error }

class CustomDialog {
  static void showSnackBar(
      {required BuildContext context, required String message, required DialogType type, Duration? duration}) {
    final snackBar = SnackBar(
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: type == DialogType.success
          ? Colors.green
          : type == DialogType.warning
              ? Colors.amber
              : Colors.redAccent,
      content: Row(
        children: [
          Icon(
            type == DialogType.success
                ? Icons.check_circle
                : type == DialogType.warning
                    ? Icons.report_problem
                    : Icons.dangerous,
            color: darkBackColor,
          ),
          const Spacer(),
          Text(
            message,
            style: const TextStyle(
              color: darkBackColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showDeleteAlertDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(defaultPadding),
              actionsPadding: const EdgeInsets.all(defaultPadding),
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white10), borderRadius: BorderRadius.all(Radius.circular(10))),
              title:
                  Center(child: Text(LocaleKeys.actions_warning.locale(), style: const TextStyle(color: titleColor))),
              backgroundColor: darkSecondaryColor,
              content: Text(
                message,
                style: const TextStyle(color: lightSecondaryColor),
              ),
              actions: [const AppCancelDeleteButton(), AppDeleteButton(onConfirm: onConfirm)]);
        });
  }
}
