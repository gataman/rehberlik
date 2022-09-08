import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class AppButtonStyle {
  static get deleteButtonStyle => ElevatedButton.styleFrom(primary: warningColor);

  static get cancelButtonStyle => ElevatedButton.styleFrom(primary: warningColor);

  static get icDelete => const Icon(
        Icons.delete,
        size: 18,
      );

  static get icCancel => const Icon(
        Icons.cancel_outlined,
        size: 18,
      );
}
