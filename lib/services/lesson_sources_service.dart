import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lesson_source.dart';
import 'base/db_base.dart';

class LessonSourceService implements DBBase<LessonSource> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "lesson_sources";

  @override
  Future<String> add({required LessonSource object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: LessonSource.fromFirestore,
          toFirestore: (LessonSource object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> update({required LessonSource object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<LessonSource> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (LessonSource object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: LessonSource.fromFirestore,
            toFirestore: (LessonSource object, options) => object.toFirestore(),
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

  Future<LessonSource?> get({required String id}) async {
    var colRef = _db.collection(_mainRef).doc(id).withConverter(
        fromFirestore: LessonSource.fromFirestore, toFirestore: (LessonSource object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    return docSnap.data();
  }

  Future<List<LessonSource>?> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where('').withConverter(
        fromFirestore: LessonSource.fromFirestore, toFirestore: (LessonSource object, _) => object.toFirestore());

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

  Future<void> deleteAll({required List<LessonSource> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (LessonSource object in list) {
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
