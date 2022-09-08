import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/study_program.dart';
import 'base/db_base.dart';

class StudyProgramService implements DBBase<StudyProgram> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "study_programs";
  final _subRef = "student_programs";

  @override
  Future<String> add({required StudyProgram object}) async {
    final docRef = _db
        .collection(_mainRef)
        .doc(object.studentID)
        .collection(_subRef)
        .withConverter(
          fromFirestore: StudyProgram.fromFirestore,
          toFirestore: (StudyProgram object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  Future<void> deleteWithStudent({required String objectID, required String studentID}) {
    return _db.collection(_mainRef).doc(studentID).collection(_subRef).doc(objectID).delete();
  }

  @override
  Future<void> update({required StudyProgram object}) {
    final ref = _db.collection(_mainRef).doc(object.studentID).collection(_subRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<StudyProgram> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (StudyProgram object in list) {
      var docRef = _db
          .collection(_mainRef)
          .doc(object.studentID)
          .collection(_subRef)
          .withConverter(
            fromFirestore: StudyProgram.fromFirestore,
            toFirestore: (StudyProgram object, options) => object.toFirestore(),
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

  Future<List<StudyProgram>?> getAll(
      {required String studentID, required DateTime startTime, required DateTime endTime, Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .doc(studentID)
        .collection(_subRef)
        .where("date", isGreaterThanOrEqualTo: startTime)
        .where("date", isLessThanOrEqualTo: endTime)
        .withConverter(fromFirestore: StudyProgram.fromFirestore, toFirestore: (StudyProgram object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  @override
  Future<void> delete({required String objectID}) {
    return _db.collection(_mainRef).doc(objectID).delete();
  }
}
