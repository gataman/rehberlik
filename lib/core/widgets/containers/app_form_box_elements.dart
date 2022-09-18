import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class AppFormBoxElements extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const AppFormBoxElements({Key? key, required this.formKey, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SizedBox(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            direction: Axis.horizontal,
            children: children,
          ),
        ),
      ),
    );
  }
}
