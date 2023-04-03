import '../common/locator.dart';
import '../models/question_follow.dart';
import '../services/question_follow_service.dart';

class QuestionFollowRepository implements QuestionFollowService {
  final QuestionFollowService _service = locator<QuestionFollowService>();

  @override
  Future<String> add({required QuestionFollow object}) => _service.add(object: object);

  @override
  Future<void> addAll({required List<QuestionFollow> list}) => _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<List<QuestionFollow>?> getAll(
          {required String studentID,
          required DateTime startTime,
          required DateTime endTime,
          Map<String, dynamic>? filters}) =>
      _service.getAll(studentID: studentID, startTime: startTime, endTime: endTime);

  @override
  Future<void> update({required QuestionFollow object}) => _service.update(object: object);

  @override
  Future<void> deleteWithStudent({required String objectID, required String studentID}) =>
      _service.deleteWithStudent(objectID: objectID, studentID: studentID);
}
