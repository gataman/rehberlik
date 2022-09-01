import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/widgets/locale_text.dart';
import 'package:rehberlik/core/init/locale_keys.g.dart';

class AppCancelFormButton extends StatelessWidget {
  const AppCancelFormButton({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: warningColor,
      ),
      onPressed: onPressed,
      child: Row(
        children: const [
          Icon(
            Icons.cancel,
            color: secondaryColor,
          ),
          Expanded(
            child: Center(
              child: LocaleText(
                text: LocaleKeys.actions_cancel,
                color: secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
