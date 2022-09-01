import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/services/base/db_base.dart';

class ClassesService implements DBBase<Classes> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "classes";

  @override
  Future<String> add({required Classes object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Classes.fromFirestore,
          toFirestore: (Classes object, options) => object.toFirestore(),
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
  Future<void> update({required Classes object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<Classes> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Classes object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Classes.fromFirestore,
            toFirestore: (Classes object, options) => object.toFirestore(),
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

  Future<Classes?> get({required String classID}) async {
    var docRef = _db.collection(_mainRef).doc(classID).withConverter(
        fromFirestore: Classes.fromFirestore,
        toFirestore: (Classes object, _) => object.toFirestore());

    final docSnap = await docRef.get();

    return docSnap.data();
  }

  Future<List<Classes>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .where("")
        .orderBy("className")
        .withConverter(
            fromFirestore: Classes.fromFirestore,
            toFirestore: (Classes object, _) => object.toFirestore());

    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  Stream<QuerySnapshot<Classes?>> getAllWithStream(
      {required String schoolID, Map<String, dynamic>? filters}) {
    final data = _db
        .collection(_mainRef)
        .where("schoolID", isEqualTo: schoolID)
        .orderBy("className")
        .withConverter(
            fromFirestore: Classes.fromFirestore,
            toFirestore: (Classes object, _) => object.toFirestore())
        .snapshots();

    return data;
  }
}
