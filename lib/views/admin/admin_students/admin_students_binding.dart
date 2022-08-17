import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_students/admin_students_controller.dart';

class AdminStudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminStudentsController());
  }
}
