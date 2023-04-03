import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../models/teacher.dart';
import 'base/db_base.dart';

class TeacherService implements DBBase<Teacher> {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _mainRef = "teachers";

  @override
  Future<String> add({required Teacher object}) async {
    final docRef = _db
        .collection(_mainRef)
        .withConverter(
          fromFirestore: Teacher.fromFirestore,
          toFirestore: (Teacher object, options) => object.toFirestore(),
        )
        .doc();

    await docRef.set(object);
    return docRef.id;
  }

  @override
  Future<void> delete({required String objectID}) => _db.collection(_mainRef).doc(objectID).delete();

  @override
  Future<void> update({required Teacher object}) {
    final ref = _db.collection(_mainRef).doc(object.id);
    return ref.update(object.toFirestore());
  }

  Future<List<Teacher>> getAll({Map<String, dynamic>? filters}) async {
    var colRef = _db
        .collection(_mainRef)
        .where("")
        .withConverter(fromFirestore: Teacher.fromFirestore, toFirestore: (Teacher object, _) => object.toFirestore());
    filters?.forEach((key, value) {
      colRef = colRef.where(key, isEqualTo: value);
    });

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    return list;
  }

  @override
  Future<void> addAll({required List<Teacher> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Teacher object in list) {
      var docRef = _db
          .collection(_mainRef)
          .withConverter(
            fromFirestore: Teacher.fromFirestore,
            toFirestore: (Teacher object, options) => object.toFirestore(),
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

  Future<void> updateAll({required List<Teacher> list}) async {
    var batch = _db.batch();
    var count = 1;

    for (Teacher object in list) {
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

  Future<String> uploadTeacherImage(
      {required XFile imageFile, required String schoolID, required String imageFileName}) async {
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
