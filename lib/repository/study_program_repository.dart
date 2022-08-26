import 'package:get/get.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/services/study_program_service.dart';

class StudyProgramRepository implements StudyProgramService {
  final StudyProgramService _service = Get.put(StudyProgramService());

  @override
  Future<String> add({required StudyProgram object}) =>
      _service.add(object: object);

  @override
  Future<void> addAll({required List<StudyProgram> list}) =>
      _service.addAll(list: list);

  @override
  Future<void> delete({required String objectID}) =>
      _service.delete(objectID: objectID);

  @override
  Future<List<StudyProgram>?> getAll(
          {required String studentID,
          required DateTime startTime,
          required DateTime endTime,
          Map<String, dynamic>? filters}) =>
      _service.getAll(
          studentID: studentID, startTime: startTime, endTime: endTime);

  @override
  Future<void> update({required StudyProgram object}) =>
      _service.update(object: object);

  @override
  Future<void> deleteWithStudent(
          {required String objectID, required String studentID}) =>
      _service.deleteWithStudent(objectID: objectID, studentID: studentID);
}
