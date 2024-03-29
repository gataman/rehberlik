import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../common/locator.dart';
import '../models/student.dart';
import '../models/student_with_class.dart';
import '../services/student_service.dart';

class StudentRepository implements StudentService {
  final StudentService _service = locator<StudentService>();

  @override
  Future<String> add({required Student object}) => _service.add(object: object);

  @override
  Future<void> delete({required String objectID}) => _service.delete(objectID: objectID);

  @override
  Future<void> update({required Student object}) => _service.update(object: object);

  @override
  Future<List<Student>> getAll({Map<String, dynamic>? filters}) => _service.getAll(filters: filters);

  @override
  Future<void> addAll({required List<Student> list}) => _service.addAll(list: list);

  @override
  Stream<QuerySnapshot<Student?>> getAllWithStream(
          {required String classID, Map<String, dynamic>? filters}) =>
      _service.getAllWithStream(classID: classID);

  @override
  Future<List<Student>> getAllWithSchoolID({required String schoolID, Map<String, dynamic>? filters}) =>
      _service.getAllWithSchoolID(schoolID: schoolID);

  @override
  Future<String> uploadStudentImage(
          {required XFile imageFile, required String schoolID, required String imageFileName}) =>
      _service.uploadStudentImage(imageFile: imageFile, schoolID: schoolID, imageFileName: imageFileName);

  @override
  Future<void> updateAll({required List<Student> list}) => _service.updateAll(list: list);

  @override
  Future<List<StudentWithClass>> getStudentWithClass(
          {required String schoolID, Map<String, dynamic>? filters}) =>
      _service.getStudentWithClass(schoolID: schoolID);

  @override
  Future<void> deleteWithClassID({required String classID}) => _service.deleteWithClassID(classID: classID);
}
