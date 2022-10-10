import 'package:flutter/material.dart';
import 'constants.dart';
import '../core/init/extentions.dart';
import '../core/init/locale_keys.g.dart';
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
              //contentPadding: const EdgeInsets.all(defaultPadding),
              actionsPadding: const EdgeInsets.all(defaultPadding),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              titlePadding: EdgeInsets.zero,
              title: Center(
                  child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.actions_warning.locale(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Expanded(
                  child: AppDeleteButton(onConfirm: () {
                    onConfirm();
                    Navigator.of(ctx).pop();
                  }),
                )
              ]);
        });
  }
}

/*
Expanded(
                      child: Text(LocaleKeys.actions_warning.locale(),
                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge)),
                 
*/
