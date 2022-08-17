library admin_message_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_messages/admin_message_controller.dart';

part 'widgets/admin_message_content.dart';

class AdminMessageView extends StatelessWidget {
  const AdminMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Admin Message çalıştı");
    return const AdminMessageContent();
  }
}
