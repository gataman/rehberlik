import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehberlik/models/lesson.dart';
import 'package:rehberlik/services/base/db_base.dart';

class LessonService implements DBBase<Lesson> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "lessons";

  @override
  Future<String> add({required Lesson object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Lesson.fromFirestore,
          toFirestore: (Lesson object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> delete({required String objectID}) =>
      _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> update({required Lesson object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  Future<List<Lesson>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where("").withConverter(
        fromFirestore: Lesson.fromFirestore,
        toFirestore: (Lesson object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  @override
  Future<void> addAll({required List<Lesson> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Lesson lesson in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Lesson.fromFirestore,
            toFirestore: (Lesson object, options) => object.toFirestore(),
          )
          .doc();
      batch.set(docRef, lesson);

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }
    return batch.commit();
  }
}
