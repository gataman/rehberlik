import 'package:flutter/material.dart';

import '../../init/extentions.dart';
import '../../init/locale_keys.g.dart';

class AppDeleteButton extends StatelessWidget {
  const AppDeleteButton({Key? key, required this.onConfirm}) : super(key: key);

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
      onPressed: onConfirm,
      label: Text(
        LocaleKeys.actions_delete.locale(),
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
    );
  }
}
