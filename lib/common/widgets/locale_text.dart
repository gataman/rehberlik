import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/core/init/extentions.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<String>? args;

  const LocaleText(
      {Key? key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text.locale(args),
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
