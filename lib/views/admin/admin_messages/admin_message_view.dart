library admin_message_view;

import 'package:flutter/material.dart';
import 'package:rehberlik/views/admin/admin_base/admin_base_view.dart';
part 'widgets/admin_message_content.dart';

class AdminMessageView extends AdminBaseView {
  const AdminMessageView({Key? key}) : super(key: key);

  @override
  Widget get firstView => const Text('Mesajlar');

  @override
  Widget get secondView => const Text('');
}
