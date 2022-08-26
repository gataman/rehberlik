import 'package:get/get.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/views/admin/admin_trial_exam_detail/admin_trial_exam_result_controller.dart';

class AdminTrialExamResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminTrialExamResultController());
  }
}
