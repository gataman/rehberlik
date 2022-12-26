import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/helpers/lesson_with_subject.dart';
import '../models/lesson.dart';
import '../models/subject.dart';
import 'base/db_base.dart';

class LessonService implements DBBase<Lesson> {
  final _db = FirebaseFirestore.instance;
  final _mainRef = "lessons";
  final _subRef = "subjects";

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
  Future<void> delete({required String objectID}) => _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> update({required Lesson object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  Future<List<Lesson>> getAll({Map<String, dynamic>? filters}) async {
    List<Lesson> list = await _getLessonList(filters);
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

  Future<List<LessonWithSubject>> getAllWithSubjects({Map<String, dynamic>? filters}) async {
    final lessonWithSubjectList = <LessonWithSubject>[];

    List<Lesson> lessonList = await _getLessonList(filters);

    for (var lesson in lessonList) {
      List<Subject> subjectList = await _getSubjectList(lesson);

      final lessonWithSubject = LessonWithSubject(lesson: lesson, subjectList: subjectList);
      lessonWithSubjectList.add(lessonWithSubject);
    }

    return lessonWithSubjectList;
  }

  Future<List<Lesson>> _getLessonList(Map<String, dynamic>? filters) async {
    var colRef = _db
        .collection(_mainRef)
        .where("")
        .withConverter(fromFirestore: Lesson.fromFirestore, toFirestore: (Lesson object, _) => object.toFirestore());
    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final lessonList = docSnap.docs.map((e) => e.data()).toList();
    return lessonList;
  }

  Future<List<Subject>> _getSubjectList(Lesson lesson) async {
    var subRef = _db
        .collection(_mainRef)
        .doc(lesson.id)
        .collection(_subRef)
        .withConverter(fromFirestore: Subject.fromFirestore, toFirestore: (Subject object, _) => object.toFirestore());

    final subjectDocSnap = await subRef.get();
    final subjectList = subjectDocSnap.docs.map((e) => e.data()).toList();
    return subjectList;
  }
}
