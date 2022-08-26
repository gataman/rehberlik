import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';

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
      this.textColor = secondaryColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
