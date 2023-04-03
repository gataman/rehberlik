import '../common/locator.dart';
import '../models/trial_exam_student_result.dart';
import '../services/trial_exam_student_result_service.dart';

class TrialExamStudentResultRepository implements TrialExamStudentResultService {
  final TrialExamStudentResultService _service = locator<TrialExamStudentResultService>();

  @override
  Future<String> add({required TrialExamStudentResult object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<void> update({required TrialExamStudentResult object}) => _service.update(object: object);

  @override
  Future<List<TrialExamStudentResult>?> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<TrialExamStudentResult> list}) => _service.addAll(list: list);

  @override
  Future<void> deleteAll({required List<TrialExamStudentResult> list}) => _service.deleteAll(list: list);

  @override
  Future<TrialExamStudentResult?> get({required String studentID}) => _service.get(studentID: studentID);
}
