import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_lessons/admin_lessons_controller.dart';

class AdminLessonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminLessonsController());
  }
}
