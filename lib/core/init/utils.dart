import 'package:flutter/material.dart';

class Utils {
  static void checkRouteArg(
      {required BuildContext context, required String route}) {
    final navigator = Navigator.of(context);
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg == null) {
      Future.delayed(Duration.zero).then((_) {
        navigator.pushReplacementNamed(route);
      });
    }
  }
}
