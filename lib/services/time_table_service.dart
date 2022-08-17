import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/models/time_table.dart';
import 'package:rehberlik/services/base/db_base.dart';

class TimeTableService implements DBBase<TimeTable> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "time_tables";

  @override
  Future<String> add({required TimeTable object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: TimeTable.fromFirestore,
          toFirestore: (TimeTable object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> update({required TimeTable object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<TimeTable> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TimeTable object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: TimeTable.fromFirestore,
            toFirestore: (TimeTable object, options) => object.toFirestore(),
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

  Future<List<TimeTable>?> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where('').withConverter(
        fromFirestore: TimeTable.fromFirestore,
        toFirestore: (TimeTable object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    debugPrint("Gelen List ${list.toString()}");
    return list;
  }

  @override
  Future<void> delete({required String objectID}) {
    return _db.collection(_mainRef).doc(objectID).delete();
  }

  Future<void> deleteAll({required List<TimeTable> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (TimeTable object in list) {
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
