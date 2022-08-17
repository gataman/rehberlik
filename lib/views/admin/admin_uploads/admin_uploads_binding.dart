import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_uploads/admin_uploads_controller.dart';

class AdminUploadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminUploadsController());
  }
}
