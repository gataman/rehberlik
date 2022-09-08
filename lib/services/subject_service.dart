import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/locator.dart';
import '../models/subject.dart';
import 'base/db_base.dart';
import 'time_table_service.dart';

class SubjectService implements DBBase<Subject> {
  final _db = FirebaseFirestore.instance;
  final TimeTableService _timeTableService = locator<TimeTableService>();
  final _mainRef = "lessons";
  final _subRef = "subjects";

  @override
  Future<String> add({required Subject object}) async {
    final docRef = _db
        .collection(_mainRef)
        .doc(object.lessonID)
        .collection(_subRef)
        .withConverter(
          fromFirestore: Subject.fromFirestore,
          toFirestore: (Subject object, options) => object.toFirestore(),
        )
        .doc();
    await docRef.set(object);
    return docRef.id;
  }

  Future<void> deleteWithLessonID({required String objectID, required String lessonID}) async {
    return _db.collection(_mainRef).doc(lessonID).collection(_subRef).doc(objectID).delete().then((value) async {
      var timeTableList = await _timeTableService.getAll(filters: {'subjectID': objectID});

      if (timeTableList != null) {
        _timeTableService.deleteAll(list: timeTableList);
      }
    });
  }

  @override
  Future<void> update({required Subject object}) {
    final ref = _db.collection(_mainRef).doc(object.lessonID).collection(_subRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  @override
  Future<void> addAll({required List<Subject> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Subject object in list) {
      var docRef = _db
          .collection(_mainRef)
          .doc(object.lessonID)
          .collection(_subRef)
          .withConverter(
            fromFirestore: Subject.fromFirestore,
            toFirestore: (Subject object, options) => object.toFirestore(),
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

  Future<List<Subject>> getAll({required String lessonID, Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .doc(lessonID)
        .collection(_subRef)
        .where("")
        .withConverter(fromFirestore: Subject.fromFirestore, toFirestore: (Subject object, _) => object.toFirestore());

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
