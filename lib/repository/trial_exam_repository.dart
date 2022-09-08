import '../common/locator.dart';
import '../models/trial_exam.dart';
import '../services/trial_exam_service.dart';

class TrialExamRepository implements TrialExamService {
  final TrialExamService _service = locator<TrialExamService>();

  @override
  Future<String> add({required TrialExam object}) => _service.add(object: object);

  @override
  Future<void> addAll({required List<TrialExam> list}) => _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<List<TrialExam>?> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> update({required TrialExam object}) => _service.update(object: object);

  @override
  Future<void> deleteAll({required List<TrialExam> list}) => _service.deleteAll(list: list);
}
