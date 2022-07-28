import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/meetings.dart';
import 'package:rehberlik/services/base/db_base.dart';

class MeetingService implements DBBase<Meetings> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "meetings";

  @override
  Future<String> add({required Meetings object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Meetings.fromFirestore,
          toFirestore: (Meetings object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> delete({required String objectID}) {
    return _db.collection(_mainRef).doc(objectID).delete();
  }

  @override
  Future<void> update({required Meetings object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<Meetings> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Meetings object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Meetings.fromFirestore,
            toFirestore: (Meetings object, options) => object.toFirestore(),
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

  Future<List<Meetings>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where("").withConverter(
        fromFirestore: Meetings.fromFirestore,
        toFirestore: (Meetings object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  Future<List<Meetings>> getAllWithTime(
      {required DateTime startTime, required DateTime endTime}) async {
    var colRef = _db
        .collection(_mainRef)
        .where("from", isGreaterThan: startTime)
        .where("from", isLessThan: endTime)
        .withConverter(
            fromFirestore: Meetings.fromFirestore,
            toFirestore: (Meetings object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }
}
