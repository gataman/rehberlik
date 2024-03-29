import 'package:flutter/material.dart';

class AgendaBoxNewEventFormField extends StatelessWidget {
  const AgendaBoxNewEventFormField({
    Key? key,
    required TextEditingController subjectController,
  })  : _subjectController = subjectController,
        super(key: key);

  final TextEditingController _subjectController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return "Lütfen konu yazınız!";
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      controller: _subjectController,
      decoration: InputDecoration(
        hintText: "Randevu Konusu",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
