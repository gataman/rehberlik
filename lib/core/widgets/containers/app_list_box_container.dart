import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class AppBoxContainer extends StatelessWidget {
  const AppBoxContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: defaultBoxDecoration,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: minimumBoxHeight),
          child: Padding(padding: const EdgeInsets.only(bottom: defaultPadding), child: child),
        ));
  }
}
