import 'package:image_picker/image_picker.dart';
import '../common/locator.dart';
import '../models/teacher.dart';
import '../services/teacher_service.dart';

class TeacherRepository implements TeacherService {
  final TeacherService _service = locator<TeacherService>();

  @override
  Future<String> add({required Teacher object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<void> update({required Teacher object}) => _service.update(object: object);

  @override
  Future<List<Teacher>> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<Teacher> list}) => _service.addAll(list: list);

  @override
  Future<String> uploadTeacherImage(
          {required XFile imageFile, required String schoolID, required String imageFileName}) =>
      _service.uploadTeacherImage(imageFile: imageFile, schoolID: schoolID, imageFileName: imageFileName);

  @override
  Future<void> updateAll({required List<Teacher> list}) => _service.updateAll(list: list);
}
