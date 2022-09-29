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
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            Icons.cancel,
            color: Theme.of(context).colorScheme.onError,
          ),
          Expanded(
            child: Center(
              child: LocaleText(
                text: LocaleKeys.actions_cancel,
                textStyle: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
