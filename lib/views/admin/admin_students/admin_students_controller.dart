import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_imports.dart';
import 'package:rehberlik/views/admin/admin_student_detail/study_program/admin_study_program_controller.dart';
import 'package:rehberlik/views/admin/admin_student_detail/time_table/student_time_table_controller.dart';

class AdminStudentsController extends AdminBaseController {
  final classController = Get.put(AdminClassesController());

  final _programController = Get.put(AdminStudyProgramController());
  final _timeTableController = Get.put(StudentTimeTableController());

  final Rxn<Student> selectedStudent = Rxn<Student>();

  void showStudentDetail(Student student) {
    if (selectedStudent.value != student) {
      _programController.programList.value = null;
      _timeTableController.timeTableList.value = null;
    }
    selectedStudent.value = student;
    Get.toNamed(Constants.routeStudentDetail);
  }
}
