import 'package:flutter/material.dart';
import 'package:rehberlik/core/widgets/text_form_fields/app_outline_text_form_field.dart';

import '../../../common/constants.dart';
import '../../../responsive.dart';

class CustomFormDialog extends StatefulWidget {
  const CustomFormDialog({Key? key, required this.child, required this.formElementList}) : super(key: key);
  final Widget child;
  final List<FormElement> formElementList;

  @override
  State<CustomFormDialog> createState() => _CustomFormDialogState();
}

class _CustomFormDialogState extends State<CustomFormDialog> {
  final double _radius = 10;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDialog(context),
      child: widget.child,
    );
  }

  _showDialog(BuildContext context) {
    double width = Responsive.dialogWidth(context);
    double height = Responsive.dialogHeight(context);
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
            //contentPadding: const EdgeInsets.all(defaultPadding),
            actionsPadding: const EdgeInsets.all(defaultPadding),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.all(Radius.circular(_radius))),
            titlePadding: EdgeInsets.zero,
            title: Center(
              child: Align(
                alignment: Alignment.topRight,
                child: _closeButton(ctx, context),
              ),
            ),
            content: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _getFormElements(),
              )),
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [const Text('dddd')]);
      },
    );
  }

  IconButton _closeButton(BuildContext ctx, BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(ctx).pop();
        },
        icon: Icon(
          Icons.cancel,
          color: Theme.of(context).colorScheme.primary,
        ));
  }

  List<Widget> _getFormElements() {
    final elementWidgetList = <Widget>[];

    for (var element in widget.formElementList) {
      elementWidgetList.add(Text(element.label));
    }
    return elementWidgetList;
  }
}

class FormElement {
  final String label;
  final String? value;
  final bool? isSecure;

  FormElement({required this.label, this.value, this.isSecure});
}
