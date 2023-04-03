import '../common/locator.dart';
import '../models/trial_exam_class_result.dart';
import '../services/trial_exam_class_result_service.dart';

class TrialExamClassResultRepository implements TrialExamClassResultService {
  final TrialExamClassResultService _service = locator<TrialExamClassResultService>();

  @override
  Future<String> add({required TrialExamClassResult object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<void> update({required TrialExamClassResult object}) => _service.update(object: object);

  @override
  Future<List<TrialExamClassResult>?> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<TrialExamClassResult> list}) => _service.addAll(list: list);

  @override
  Future<void> deleteAll({required List<TrialExamClassResult> list}) => _service.deleteAll(list: list);

  @override
  Future<void> deleteWithParentID({required String parentID}) => _service.deleteWithParentID(parentID: parentID);
}
