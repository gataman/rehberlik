import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_view_controller.dart';

class AdminViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminViewController());
  }
}
