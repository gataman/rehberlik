import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/services/base/db_base.dart';

class StudentService implements DBBase<Student> {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _mainRef = "students";
  final _classesRef = "classes";

  @override
  Future<String> add({required Student object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Student.fromFirestore,
          toFirestore: (Student object, options) => object.toFirestore(),
        )
        .doc();

    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> delete({required String objectID}) =>
      _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> update({required Student object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  Future<List<Student>> getAll(
      {required String classID, Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .where("classID", isEqualTo: classID)
        .withConverter(
            fromFirestore: Student.fromFirestore,
            toFirestore: (Student object, _) => object.toFirestore());
    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  Future<List<Student>> getAllWithSchoolID(
      {required String schoolID, Map<String, dynamic>? filters}) async {
    final List<Student> studentList = [];

    var classesRef = _db
        .collection(_classesRef)
        .where("schoolID", isEqualTo: schoolID)
        .withConverter(
            fromFirestore: Classes.fromFirestore,
            toFirestore: (Classes object, _) => object.toFirestore());
    filters?.forEach((key, value) {
      classesRef = classesRef.where(key, isEqualTo: value);
    });

    final classSnap = await classesRef.get();
    final classesList = classSnap.docs.map((e) => e.data()).toList();

    for (var classes in classesList) {
      final classStudentList = await getAll(classID: classes.id!);
      studentList.addAll(classStudentList);
    }

    return studentList;
  }

  Future<List<StudentWithClass>> getStudentWithClass(
      {required String schoolID, Map<String, dynamic>? filters}) async {
    final List<StudentWithClass> studentWithClassesList = [];

    var classesRef = _db
        .collection(_classesRef)
        .where("schoolID", isEqualTo: schoolID)
        .withConverter(
            fromFirestore: Classes.fromFirestore,
            toFirestore: (Classes object, _) => object.toFirestore());
    filters?.forEach((key, value) {
      classesRef = classesRef.where(key, isEqualTo: value);
    });

    final classSnap = await classesRef.get();
    final classesList = classSnap.docs.map((e) => e.data()).toList();

    for (var classes in classesList) {
      final classStudentList = await getAll(classID: classes.id!);
      classStudentList.sort((a, b) =>
          int.parse(a.studentNumber!).compareTo(int.parse(b.studentNumber!)));
      StudentWithClass studentWithClass = StudentWithClass(classes: classes);
      studentWithClass.studentList = classStudentList;
      studentWithClassesList.add(studentWithClass);
    }

    if (studentWithClassesList.length > 1) {
      studentWithClassesList
          .sort((a, b) => a.classes.className!.compareTo(b.classes.className!));
    }

    return studentWithClassesList;
  }

  @override
  Future<void> addAll({required List<Student> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Student object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Student.fromFirestore,
            toFirestore: (Student object, options) => object.toFirestore(),
          )
          .doc();
      batch.set(docRef, object);

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }

    await batch.commit();
    return Future.value();
  }

  Future<void> updateAll({required List<Student> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Student object in list) {
      final ref = _db.collection(_mainRef).doc(object.id);
      batch.update(ref, object.toFirestore());

      if (count % 500 == 0) {
        await batch.commit();
        batch = _db.batch();
      }

      count++;
    }

    await batch.commit();
    return Future.value();
  }

  Stream<QuerySnapshot<Student?>> getAllWithStream(
      {required String classID, Map<String, dynamic>? filters}) {
    final data = _db
        .collection(_mainRef)
        .where("classID", isEqualTo: classID)
        .orderBy("studentNumber")
        .withConverter(
            fromFirestore: Student.fromFirestore,
            toFirestore: (Student object, _) => object.toFirestore())
        .snapshots();

    return data;
  }

  Future<String> uploadStudentImage(
      {required XFile imageFile,
      required String schoolID,
      required String imageFileName}) async {
    final storageRef = _storage.ref().child(schoolID).child(imageFileName);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': imageFile.path},
    );

    if (kIsWeb) {
      await storageRef.putData(await imageFile.readAsBytes(), metadata);
    } else {
      await storageRef.putFile(File(imageFile.path), metadata);
    }

    //final downloadUrl = await storageRef.getDownloadURL();
    return await storageRef.getDownloadURL();
  }
}
