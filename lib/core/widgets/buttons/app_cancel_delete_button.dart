import 'package:flutter/material.dart';

import '../../init/extentions.dart';
import '../../init/locale_keys.g.dart';

class AppCancelDeleteButton extends StatelessWidget {
  const AppCancelDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
      onPressed: () => Navigator.pop(context),
      label: Text(
        LocaleKeys.actions_cancel.locale(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      icon: Icon(
        Icons.cancel,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
