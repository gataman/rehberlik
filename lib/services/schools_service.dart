import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehberlik/common/custom_result.dart';
import 'package:rehberlik/models/school.dart';
import 'package:rehberlik/services/base/db_base.dart';

class SchoolService implements DBBase<School> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "schools";

  @override
  Future<String> add({required School object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: School.fromFirestore,
          toFirestore: (School object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> delete({required String objectID}) =>
      _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> update({required School object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<School> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (School object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: School.fromFirestore,
            toFirestore: (School object, options) => object.toFirestore(),
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

  Future<List<School>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db.collection(_mainRef).where("").withConverter(
        fromFirestore: School.fromFirestore,
        toFirestore: (School object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }
}
