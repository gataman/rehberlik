import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_subjects/admin_subjects_controller.dart';

class AdminSubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminSubjectsController());
  }
}
