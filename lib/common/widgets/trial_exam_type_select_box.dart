import 'package:flutter/material.dart';
import '../constants.dart';

class TrialExamTypeSelectBox extends StatelessWidget {
  final ValueChanged<int> valueChanged;
  final int? typeIndex;

  const TrialExamTypeSelectBox({Key? key, required this.valueChanged, this.typeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: -5, horizontal: defaultPadding / 2),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      value: typeIndex != null ? Constants.trialExamType[typeIndex!] : null,
      icon: const Icon(Icons.keyboard_arrow_down),
      hint: typeIndex == null ? const Center(child: Text('Sınav tipi seçin')) : null,
      onChanged: (String? newValue) {
        valueChanged(Constants.trialExamType.indexOf(newValue!));
      },
      items: Constants.trialExamType.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList(),
    );
  }
}
