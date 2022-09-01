import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';

class AppBoxTitle extends StatelessWidget {
  final String title;
  final Color? color;

  const AppBoxTitle({Key? key, required this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color ?? titleColor,
        ),
      ),
    );
  }
}
