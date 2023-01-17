import 'package:rehberlik/models/lesson_source.dart';

import '../common/locator.dart';
import '../services/lesson_sources_service.dart';

class LessonSourceRepository implements LessonSourceService {
  final LessonSourceService _service = locator<LessonSourceService>();

  @override
  Future<String> add({required LessonSource object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<void> update({required LessonSource object}) => _service.update(object: object);

  @override
  Future<List<LessonSource>?> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<LessonSource> list}) => _service.addAll(list: list);

  @override
  Future<void> deleteAll({required List<LessonSource> list}) => _service.deleteAll(list: list);

  @override
  Future<LessonSource?> get({required String id}) => _service.get(id: id);
}
