import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonWithIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const ButtonWithIcon(
      {Key? key,
      required this.labelText,
      required this.icon,
      this.backgroundColor = Colors.amber,
      this.textColor = darkSecondaryColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            Expanded(
              child: Center(
                child: Text(
                  labelText,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
