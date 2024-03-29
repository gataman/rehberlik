import 'package:cloud_firestore/cloud_firestore.dart';
import 'trial_exam_class_result_service.dart';
import 'trial_exam_result_service.dart';

import '../common/locator.dart';
import '../models/trial_exam.dart';
import 'base/db_base.dart';

class TrialExamService implements DBBase<TrialExam> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "trial_exams";
  final TrialExamResultService _trialExamResultService = locator<TrialExamResultService>();
  final TrialExamClassResultService _trialExamClassResultService = locator<TrialExamClassResultService>();

  @override
  Future<String> add({required TrialExam object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: TrialExam.fromFirestore,
          toFirestore: (TrialExam object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> update({required TrialExam object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<TrialExam> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TrialExam object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: TrialExam.fromFirestore,
            toFirestore: (TrialExam object, options) => object.toFirestore(),
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

  Future<TrialExam?> get({required String id}) async {
    var colRef = _db.collection(_mainRef).doc(id).withConverter(
        fromFirestore: TrialExam.fromFirestore, toFirestore: (TrialExam object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    return docSnap.data();
  }

  Future<List<TrialExam>?> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where('').withConverter(
        fromFirestore: TrialExam.fromFirestore, toFirestore: (TrialExam object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    list.sort(((a, b) => b.examDate!.compareTo(a.examDate!)));
    return list;
  }

  @override
  Future<void> delete({required String objectID}) {
    return _db.collection(_mainRef).doc(objectID).delete().then((value) {
      _trialExamResultService.deleteWithParentID(parentID: objectID);
      _trialExamClassResultService.deleteWithParentID(parentID: objectID);
    });
  }

  Future<void> deleteAll({required List<TrialExam> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TrialExam object in list) {
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
}
