import '../common/locator.dart';
import '../models/quiz.dart';
import '../services/quiz_service.dart';

class QuizRepository implements QuizService {
  final QuizService _service = locator<QuizService>();

  @override
  Future<String> add({required Quiz object}) => _service.add(object: object);

  @override
  Future<void> addAll({required List<Quiz> list}) => _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<List<Quiz>?> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> update({required Quiz object}) => _service.update(object: object);

  @override
  Future<void> deleteAll({required List<Quiz> list}) => _service.deleteAll(list: list);

  @override
  Future<Quiz?> get({required String id}) => _service.get(id: id);
}
