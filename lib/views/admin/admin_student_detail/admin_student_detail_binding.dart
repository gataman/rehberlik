import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_controller.dart';

class AdminStudentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminStudentDetailController());
  }
}
