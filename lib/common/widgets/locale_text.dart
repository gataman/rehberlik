import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../core/init/extentions.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final List<String>? args;

  const LocaleText({Key? key, required this.text, this.textStyle, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.locale(args),
      style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
    );
  }
}
