import '../common/locator.dart';
import '../models/meeting.dart';
import '../services/meeting_service.dart';

class MeetingReposityory implements MeetingService {
  final MeetingService _service = locator<MeetingService>();

  @override
  Future<String> add({required Meeting object}) => _service.add(object: object);

  @override
  Future<void> addAll({required List<Meeting> list}) => _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<List<Meeting>> getAll({Map<String, dynamic>? filters}) => _service.getAll();

  @override
  Future<void> update({required Meeting object}) => _service.update(object: object);

  @override
  Future<List<Meeting>> getAllWithTime({required DateTime startTime, required DateTime endTime}) =>
      _service.getAllWithTime(startTime: startTime, endTime: endTime);
}
