import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension StringLocalization on String {
  String locale([List<String>? args]) => this.tr(args: args);
}

extension AppTextStyle on BuildContext {
  TextStyle? get normalTextStyle => Theme.of(this).textTheme.titleMedium;
}
