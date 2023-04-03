import 'package:flutter/material.dart';

class AppConstants {
  static BoxDecoration defaultBoxDecoration(BuildContext context) => BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(color: Colors.white10),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      );
}
