import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz.dart';
import 'base/db_base.dart';

class QuizService implements DBBase<Quiz> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "quizzes";

  @override
  Future<String> add({required Quiz object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Quiz.fromFirestore,
          toFirestore: (Quiz object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> update({required Quiz object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<Quiz> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Quiz object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Quiz.fromFirestore,
            toFirestore: (Quiz object, options) => object.toFirestore(),
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

  Future<Quiz?> get({required String id}) async {
    var colRef = _db
        .collection(_mainRef)
        .doc(id)
        .withConverter(fromFirestore: Quiz.fromFirestore, toFirestore: (Quiz object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    return docSnap.data();
  }

  Future<List<Quiz>?> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .where('')
        .withConverter(fromFirestore: Quiz.fromFirestore, toFirestore: (Quiz object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  @override
  Future<void> delete({required String objectID}) {
    return _db.collection(_mainRef).doc(objectID).delete().then((value) {
      // _trialExamResultService.deleteWithParentID(parentID: objectID);
      // _trialExamClassResultService.deleteWithParentID(parentID: objectID);
    });
  }

  Future<void> deleteAll({required List<Quiz> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Quiz object in list) {
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
