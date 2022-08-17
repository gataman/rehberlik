import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_dashboard/admin_dashboard_controller.dart';

class AdminDashboardViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminDashboardController());
  }
}
