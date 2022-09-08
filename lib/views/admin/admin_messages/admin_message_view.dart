library admin_message_view;

import 'package:flutter/material.dart';
part 'widgets/admin_message_content.dart';

class AdminMessageView extends StatelessWidget {
  const AdminMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AdminMessageContent();
  }
}
