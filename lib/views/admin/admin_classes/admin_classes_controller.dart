import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/repository/classes_repository.dart';

class AdminClassesController extends GetxController {
  final _classesRepository = Get.put(ClassesRepository());
  Rxn<List<Classes>> classesList = Rxn<List<Classes>>();
  var statusAddingClass = false.obs;
  var statusOpeningDialog = false.obs;

  final editingClasses = Rxn<Classes>();
  final selectedClassesCategory = 5.obs;

  Stream<List<Classes?>> getClassesListStream({required String schoolID}) {
    Stream<List<DocumentSnapshot<Classes?>>> streamListDocument =
        _classesRepository
            .getAllWithStream(schoolID: schoolID)
            .map((querySnapshot) => querySnapshot.docs);

    Stream<List<Classes?>> streamListClasses = streamListDocument
        .map((listOfDocSnap) => listOfDocSnap.map((e) => e.data()).toList());

    return streamListClasses;
  }

  void getClassesList() async {
    final list =
        await _classesRepository.getAll(schoolID: "w7WZvgcVPKVheXnhxMHE");
    classesList.value = list;
    update();
  }

  void addClass(Classes classes) {
    changeAddingStatus(true);
    _classesRepository.add(object: classes).whenComplete(() {
      getClassesList();
      changeAddingStatus(false);
      debugPrint("İşlem tamama");
    });
  }

  void changeAddingStatus(bool status) {
    statusAddingClass.value = status;
    update();
  }

  void showClassDetail(Classes classes) {
    // Buradan detayı görünecek sınıf seçilecek
  }

  void editClass(Classes classes) {
    editingClasses.value = classes;
    selectedClassesCategory.value = classes.classLevel!;
    update();
  }

  void updateClasses(Classes classes) {
    _classesRepository.update(object: classes).whenComplete(() {
      editingClasses.value = null;
      getClassesList();
      update();
    });
  }

  void deleteClass(String classID) {
    _classesRepository.delete(objectID: classID).whenComplete(() {
      getClassesList();
      editingClasses.value = null;
      update();
    });
  }
}
