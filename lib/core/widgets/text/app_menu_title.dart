import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class AppMenuTitle extends StatelessWidget {
  final String title;
  final Color? color;

  const AppMenuTitle({Key? key, required this.title, this.color}) : super(key: key);

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
