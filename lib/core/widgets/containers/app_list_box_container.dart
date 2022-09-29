import 'package:flutter/material.dart';
import 'package:rehberlik/core/app_constants.dart';

import '../../../common/constants.dart';

class AppBoxContainer extends StatelessWidget {
  const AppBoxContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: minimumBoxHeight),
        child: Padding(padding: const EdgeInsets.only(bottom: defaultPadding), child: child),
      ),
    );
  }
}
