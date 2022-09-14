import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/classes.dart';
import '../models/school.dart';
import 'base/db_base.dart';

class SchoolService implements DBBase<School> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "schools";

  @override
  Future<String> add({required School object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: School.fromFirestore,
          toFirestore: (School object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> delete({required String objectID}) => _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> update({required School object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<School> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (School object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: School.fromFirestore,
            toFirestore: (School object, options) => object.toFirestore(),
          )
          .doc();
      batch.set(docRef, object);

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }

    return batch.commit();
  }

  Future<List<School>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .where("")
        .withConverter(fromFirestore: School.fromFirestore, toFirestore: (School object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  Future<int> getStudentCount(
      {required String schoolID, required int classLevel, Map<String, dynamic>? filters}) async {
    var studentTotalCount = 0;
    var classList = await _getClassList(schoolID, classLevel);
    for (var classes in classList) {
      final studentCount = await _getStudentCount(classes.id!);
      studentTotalCount += studentCount;
    }
    return studentTotalCount;
  }

  Future<List<Classes>> _getClassList(String schoolID, int classLevel) async {
    var classesRef = _db
        .collection("classes")
        .where("schoolID", isEqualTo: schoolID)
        .where("classLevel", isEqualTo: classLevel)
        .withConverter(fromFirestore: Classes.fromFirestore, toFirestore: (Classes object, _) => object.toFirestore());

    final classSnap = await classesRef.get();
    return classSnap.docs.map((e) => e.data()).toList();
  }

  Future<int> _getStudentCount(String classID) async {
    var classesRef = _db.collection("students").where("classID", isEqualTo: classID);
    final classSnap = await classesRef.get();

    return classSnap.size;
  }
}
