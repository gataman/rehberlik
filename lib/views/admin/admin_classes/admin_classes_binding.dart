import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';

class AdminClassesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminClassesController());
  }
}
