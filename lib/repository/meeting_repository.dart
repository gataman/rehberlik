import 'package:get/get.dart';
import 'package:rehberlik/models/meetings.dart';
import 'package:rehberlik/services/meetings_service.dart';

class MeetingReposityory implements MeetingService {
  final MeetingService _service = Get.put(MeetingService());

  @override
  Future<String> add({required Meetings object}) =>
      _service.add(object: object);

  @override
  Future<void> addAll({required List<Meetings> list}) =>
      _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<List<Meetings>> getAll({Map<String, dynamic>? filters}) =>
      _service.getAll();

  @override
  Future<void> update({required Meetings object}) =>
      _service.update(object: object);

  @override
  Future<List<Meetings>> getAllWithTime(
          {required DateTime startTime, required DateTime endTime}) =>
      _service.getAllWithTime(startTime: startTime, endTime: endTime);
}
