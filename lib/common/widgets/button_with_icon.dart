import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonWithIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const ButtonWithIcon(
      {Key? key,
      required this.labelText,
      required this.icon,
      this.backgroundColor,
      this.textColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
            Expanded(
              child: Center(
                child: Text(
                  labelText,
                  style: TextStyle(color: textColor ?? Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
