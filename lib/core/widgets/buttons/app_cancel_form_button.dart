import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/locale_text.dart';
import '../../init/locale_keys.g.dart';

class AppCancelFormButton extends StatelessWidget {
  const AppCancelFormButton({Key? key, required this.onPressed}) : super(key: key);

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
            color: darkSecondaryColor,
          ),
          Expanded(
            child: Center(
              child: LocaleText(
                text: LocaleKeys.actions_cancel,
                color: darkSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
