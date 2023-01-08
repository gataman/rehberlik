import 'package:flutter/material.dart';

class FormCancelButton extends StatelessWidget {
  const FormCancelButton({Key? key, required this.onConfirm}) : super(key: key);

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
      onPressed: onConfirm,
      label: Text(
        'İptal',
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
      icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.onError),
    );
  }
}
