import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/meeting.dart';
import 'base/db_base.dart';

class MeetingService implements DBBase<Meeting> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "meetings";

  @override
  Future<String> add({required Meeting object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Meeting.fromFirestore,
          toFirestore: (Meeting object, options) => object.toFirestore(),
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
  Future<void> update({required Meeting object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<Meeting> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Meeting object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Meeting.fromFirestore,
            toFirestore: (Meeting object, options) => object.toFirestore(),
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

  Future<List<Meeting>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where("").withConverter(
        fromFirestore: Meeting.fromFirestore, toFirestore: (Meeting object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  Future<List<Meeting>> getAllWithTime({required DateTime startTime, required DateTime endTime}) async {
    var colRef = _db
        .collection(_mainRef)
        .where("from", isGreaterThan: startTime)
        .where("from", isLessThan: endTime)
        .withConverter(
            fromFirestore: Meeting.fromFirestore, toFirestore: (Meeting object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }
}
