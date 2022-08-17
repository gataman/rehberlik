import 'package:get/get.dart';
import 'package:rehberlik/views/admin/admin_trial_exam/admin_trial_exam_controller.dart';

class AdminTrialExamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminTrialExamController());
  }
}
