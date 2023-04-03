import 'package:flutter/material.dart';

class FormSaveButton extends StatelessWidget {
  const FormSaveButton({Key? key, required this.onConfirm}) : super(key: key);

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.tertiary),
      onPressed: onConfirm,
      label: Text(
        'Kaydet',
        style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
      ),
      icon: Icon(Icons.save, color: Theme.of(context).colorScheme.onTertiary),
    );
  }
}
