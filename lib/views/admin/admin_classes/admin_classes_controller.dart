import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student_with_class.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/student_repository.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';

class AdminClassesController extends AdminBaseController {
  final _box = GetStorage();
  final _classesRepository = Get.put(ClassesRepository());
  final _studentRepository = Get.put(StudentRepository());
  final tfAddFormController = Get.put(TextEditingController());

  final FocusNode classNameFocusNode = Get.put(FocusNode());

  Rxn<List<StudentWithClass>> studentWithClassList =
      Rxn<List<StudentWithClass>>();

  var statusAddingClass = false.obs;
  var statusOpeningDialog = false.obs;

  final editingClasses = Rxn<Classes>();
  final selectedClassesCategory = 5.obs;

  var selectedIndex = 0.obs;

  @override
  void onClose() {
    tfAddFormController.dispose();
    super.onClose();
  }

  void addClass(Classes classes) {
    changeAddingStatus(true);
    _classesRepository.add(object: classes).then((classID) {
      classes.id = classID;
      _addClassInLocalList(classes);
      changeAddingStatus(false);
    });
  }

  void changeAddingStatus(bool status) {
    statusAddingClass.value = status;
    update();
  }

  void showClassDetail({required Classes classes, required int index}) {
    selectedIndex.value = index;
    Get.toNamed(Constants.routeStudents, id: 1);
  }

  void editClass(Classes classes) {
    editingClasses.value = classes;
    selectedClassesCategory.value = classes.classLevel!;
    update();
  }

  void updateClasses(Classes classes) {
    _classesRepository.update(object: classes).then((value) {
      editingClasses.value = null;
      _updateOrDeleteClassInLocalList(classes: classes, isUpdate: true);
      update();
    });
  }

  void deleteClass(Classes classes) {
    _classesRepository.delete(objectID: classes.id!).whenComplete(() {
      editingClasses.value = null;
      _updateOrDeleteClassInLocalList(classes: classes, isUpdate: false);
      update();
    });
  }

  //Class and students:

  void getAllStudentWithClass() async {
    debugPrint("Get Student List Çalıştı");
    final schoolID = _box.read("schoolID");

    var _studentWithClassList =
        await _studentRepository.getStudentWithClass(schoolID: schoolID);

    studentWithClassList.value = _studentWithClassList;
  }

  void _addClassInLocalList(Classes classes) {
    var classList = studentWithClassList.value;
    final studentWithClass = StudentWithClass(classes: classes);
    classList ??= <StudentWithClass>[];
    classList.add(studentWithClass);
    studentWithClassList.refresh();
  }

  void _updateOrDeleteClassInLocalList(
      {required Classes classes, required bool isUpdate}) {
    var classList = studentWithClassList.value;
    if (classList != null) {
      final newList = classList.where((element) => element.classes == classes);
      if (newList.isNotEmpty) {
        if (isUpdate) {
          newList.first.classes = classes;
        } else {
          classList.remove(newList.first);
        }
        studentWithClassList.refresh();
      }
    }
  }

  //Students View

}
