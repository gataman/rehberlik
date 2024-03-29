import '../common/locator.dart';
import '../models/trial_exam_result.dart';
import '../services/trial_exam_result_service.dart';

class TrialExamResultRepository implements TrialExamResultService {
  final TrialExamResultService _service = locator<TrialExamResultService>();

  @override
  Future<String> add({required TrialExamResult object}) => _service.add(object: object);

  @override
  Future<void> addAll({required List<TrialExamResult> list}) => _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<List<TrialExamResult>?> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> update({required TrialExamResult object}) => _service.update(object: object);

  @override
  Future<void> deleteAll({required List<TrialExamResult> list}) => _service.deleteAll(list: list);

  @override
  Future<void> deleteWithParentID({required String parentID}) => _service.deleteWithParentID(parentID: parentID);
}
