import 'package:get/get.dart';
import 'package:rehberlik/models/subject.dart';
import 'package:rehberlik/repository/subject_repository.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';
import 'package:rehberlik/views/admin/admin_student_detail/time_table/student_time_table_controller.dart';

class AdminSubjectsController extends AdminBaseController {
  final _subjectRepository = Get.put(SubjectRepository());
  final _timeTableController = Get.put(StudentTimeTableController());

  Rxn<List<Subject>?> subjectList = Rxn<List<Subject>?>();

  var statusAddingSubject = false.obs;
  // var statusOpeningDialog = false.obs;

  final editingSubject = Rxn<Subject>();

  void getAllSubjectList({required String lessonID}) async {
    _subjectRepository.getAll(lessonID: lessonID).then((_subjectList) {
      subjectList.value = _subjectList;
    });
  }

  Future<String> addSubject(Subject subject) async {
    final subjectID = await _subjectRepository.add(object: subject);
    subject.id = subjectID;
    _addSubjectInLocalList(subject);
    _timeTableController.needUpdate = true;
    return subjectID;
  }

  Future<void> updateSubject(Subject subject) async {
    return _subjectRepository.update(object: subject).then((value) {
      _timeTableController.needUpdate = true;
      subjectList.refresh();
    });
  }

  Future<void> deleteSubject(Subject subject) {
    return _subjectRepository
        .deleteWithLessonID(objectID: subject.id!, lessonID: subject.lessonID!)
        .then((value) {
      _timeTableController.needUpdate = true;
    });
  }

  void _addSubjectInLocalList(Subject subject) {
    if (subjectList.value != null) {
      subjectList.value!.add(subject);
    } else {
      subjectList.value = <Subject>[];
      subjectList.value!.add(subject);
    }
    subjectList.refresh();
  }
}
