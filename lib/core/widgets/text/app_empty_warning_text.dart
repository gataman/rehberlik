import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/locale_text.dart';

class AppEmptyWarningText extends StatelessWidget {
  const AppEmptyWarningText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: minimumBoxHeight,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: LocaleText(text: text),
        ));
  }
}
