import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/constants.dart';

// ignore: must_be_immutable
class AppDatePickerText extends StatefulWidget {
  AppDatePickerText({Key? key, required this.valueChanged, this.initialValue}) : super(key: key);
  final ValueChanged<DateTime?> valueChanged;
  DateTime? initialValue;

  @override
  State<AppDatePickerText> createState() => _AppDatePickerTextState();
}

class _AppDatePickerTextState extends State<AppDatePickerText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: defaultBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.initialValue == null ? 'Tarih Seçin' : DateFormat("dd/MM/yyyy").format(widget.initialValue!),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialValue ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.initialValue) {
      widget.valueChanged(picked);
      setState(() {
        widget.initialValue = picked;
      });
    }
  }
}
