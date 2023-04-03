import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question_follow.dart';
import 'base/db_base.dart';

class QuestionFollowService implements DBBase<QuestionFollow> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "question_follows";
  final _subRef = "student_question_follows";

  @override
  Future<String> add({required QuestionFollow object}) async {
    final docRef = _db
        .collection(_mainRef)
        .doc(object.studentID)
        .collection(_subRef)
        .withConverter(
          fromFirestore: QuestionFollow.fromFirestore,
          toFirestore: (QuestionFollow object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  Future<void> deleteWithStudent({required String objectID, required String studentID}) {
    return _db.collection(_mainRef).doc(studentID).collection(_subRef).doc(objectID).delete();
  }

  @override
  Future<void> update({required QuestionFollow object}) {
    final ref = _db.collection(_mainRef).doc(object.studentID).collection(_subRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<QuestionFollow> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (QuestionFollow object in list) {
      var docRef = _db
          .collection(_mainRef)
          .doc(object.studentID)
          .collection(_subRef)
          .withConverter(
            fromFirestore: QuestionFollow.fromFirestore,
            toFirestore: (QuestionFollow object, options) => object.toFirestore(),
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

  Future<List<QuestionFollow>?> getAll(
      {required String studentID,
      required DateTime startTime,
      required DateTime endTime,
      Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .doc(studentID)
        .collection(_subRef)
        .where("date", isGreaterThanOrEqualTo: startTime)
        .where("date", isLessThanOrEqualTo: endTime)
        .withConverter(
            fromFirestore: QuestionFollow.fromFirestore,
            toFirestore: (QuestionFollow object, _) => object.toFirestore());

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
