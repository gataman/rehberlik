import 'package:get/get.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/services/time_table_service.dart';

class TimeTableRepository implements TimeTableService {
  final TimeTableService _service = Get.put(TimeTableService());

  @override
  Future<String> add({required TimeTable object}) =>
      _service.add(object: object);

  @override
  Future<void> addAll({required List<TimeTable> list}) =>
      _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<List<TimeTable>?> getAll({Map<String, dynamic>? filters}) =>
      _service.getAll(filters: filters);

  @override
  Future<void> update({required TimeTable object}) =>
      _service.update(object: object);

  @override
  Future<void> deleteAll({required List<TimeTable> list}) =>
      _service.deleteAll(list: list);
}
