import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_main_view/admin_main_view_controller.dart';

class AdminMainViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminMainViewController());
  }
}
