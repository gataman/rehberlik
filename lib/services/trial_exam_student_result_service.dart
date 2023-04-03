import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/trial_exam_student_result.dart';
import 'base/db_base.dart';

class TrialExamStudentResultService implements DBBase<TrialExamStudentResult> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = 'trial_exam_student_result';

  @override
  Future<String> add({required TrialExamStudentResult object}) async {
    final docRef = _db.collection(_mainRef).doc(object.studentID).withConverter(
          fromFirestore: TrialExamStudentResult.fromFirestore,
          toFirestore: (TrialExamStudentResult object, options) => object.toFirestore(),
        );
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> update({required TrialExamStudentResult object}) {
    final ref = _db.collection(_mainRef).doc(object.studentID);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> delete({required String objectID}) => _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> addAll({required List<TrialExamStudentResult> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TrialExamStudentResult object in list) {
      var docRef = _db.collection(_mainRef).doc(object.studentID).withConverter(
            fromFirestore: TrialExamStudentResult.fromFirestore,
            toFirestore: (TrialExamStudentResult object, options) => object.toFirestore(),
          );
      batch.set(docRef, object);

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }
    return batch.commit();
  }

  Future<TrialExamStudentResult?> get({required String studentID}) async {
    var colRef = _db.collection(_mainRef).doc(studentID).withConverter(
        fromFirestore: TrialExamStudentResult.fromFirestore,
        toFirestore: (TrialExamStudentResult object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    return docSnap.data();
  }

  Future<List<TrialExamStudentResult>?> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where('').withConverter(
        fromFirestore: TrialExamStudentResult.fromFirestore,
        toFirestore: (TrialExamStudentResult object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  Future<void> deleteAll({required List<TrialExamStudentResult> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TrialExamStudentResult object in list) {
      var docRef = _db.collection(_mainRef).doc(object.studentID);
      batch.delete(docRef);

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }
    return batch.commit();
  }
}
