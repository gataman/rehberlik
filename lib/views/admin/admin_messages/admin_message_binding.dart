import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_messages/admin_message_controller.dart';

class AdminMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminMessageController());
  }
}
