import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/trial_exam_result.dart';
import 'base/db_base.dart';

class TrialExamResultService implements DBBase<TrialExamResult> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "trial_exam_results";

  @override
  Future<String> add({required TrialExamResult object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: TrialExamResult.fromFirestore,
          toFirestore: (TrialExamResult object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> update({required TrialExamResult object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<TrialExamResult> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TrialExamResult object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: TrialExamResult.fromFirestore,
            toFirestore: (TrialExamResult object, options) => object.toFirestore(),
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

  Future<List<TrialExamResult>?> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where('').withConverter(
        fromFirestore: TrialExamResult.fromFirestore, toFirestore: (TrialExamResult object, _) => object.toFirestore());

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

  Future<void> deleteAll({required List<TrialExamResult> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TrialExamResult object in list) {
      var docRef = _db.collection(_mainRef).doc(object.id);
      batch.delete(docRef);

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }

    return batch.commit();
  }

  Future<void> deleteWithParentID({required String parentID}) async {
    var batch = _db.batch();
    final colRef = _db.collection(_mainRef).where('examID', isEqualTo: parentID);
    var count = 1;
    final docSnap = await colRef.get();
    for (var doc in docSnap.docs) {
      batch.delete(doc.reference);
      if (count % 500 == 0) {
        await batch.commit();
        batch.delete(doc.reference);
      }
      count++;
    }
    return batch.commit();
  }
}
