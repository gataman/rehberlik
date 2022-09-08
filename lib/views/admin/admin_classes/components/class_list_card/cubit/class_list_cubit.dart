import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/models/school_student_stats.dart';
import 'package:rehberlik/core/init/locale_manager.dart';
import 'package:rehberlik/core/init/pref_keys.dart';
import 'package:rehberlik/views/admin/admin_student_detail/admin_student_detail_imports.dart';

import '../../../../../../common/locator.dart';
import '../../../../../../models/classes.dart';
import '../../../../../../models/student_with_class.dart';
import '../../../../../../repository/classes_repository.dart';
import '../../../../../../repository/student_repository.dart';

part 'class_list_state.dart';

class ClassListCubit extends Cubit<ClassListState> {
  ClassListCubit() : super(ClassListLoadingState(schoolStatsList: SchoolStudentStats.studentStatsList));
  final _studentRepository = locator<StudentRepository>();
  final _classRepository = locator<ClassesRepository>();

  //final _box = GetStorage();

  List<StudentWithClass>? studentWithClassList;
  List<SchoolStudentStats> schoolStatsList = [];
  List<Student> allStudentList = [];

  void fetchClassList() async {
    final schoolID = SharedPrefs.instance.getString(PrefKeys.schoolID.toString());
    var list = await _studentRepository.getStudentWithClass(schoolID: schoolID!);
    studentWithClassList = list;
    _refreshList();
  }

  Future<String> addClass(Classes classes) async {
    final classID = await _classRepository.add(object: classes);
    classes.id = classID;
    _addClassInLocalList(classes);

    return classID;
  }

  Future<void> updateClasses(Classes classes) {
    return _classRepository.update(object: classes).then((value) {
      _updateOrDeleteClassInLocalList(classes: classes, isUpdate: true);
      _refreshList();
    });
  }

  Future<void> deleteClass(Classes classes) {
    return _classRepository.delete(objectID: classes.id!).whenComplete(() {
      _updateOrDeleteClassInLocalList(classes: classes, isUpdate: false);
    });
  }

  Future<void> deleteStudent(Student student) async {
    return _studentRepository.delete(objectID: student.id!).whenComplete(() {
      _updateOrDeleteStudentInLocalList(student: student);
    });
  }

  void _addClassInLocalList(Classes classes) {
    final studentWithClass = StudentWithClass(classes: classes);
    studentWithClassList ??= <StudentWithClass>[];
    studentWithClassList!.add(studentWithClass);
    _refreshList();
  }

  void _updateOrDeleteClassInLocalList({required Classes classes, required bool isUpdate}) {
    if (studentWithClassList != null) {
      final newList = studentWithClassList!.where((element) => element.classes == classes);
      if (newList.isNotEmpty) {
        if (isUpdate) {
          newList.first.classes = classes;
        } else {
          studentWithClassList!.remove(newList.first);
        }
        _refreshList();
      }
    }
  }

  void _updateOrDeleteStudentInLocalList({required Student student}) {
    if (studentWithClassList != null) {
      final newList = studentWithClassList!.where((element) => element.classes.id == student.classID);
      if (newList.isNotEmpty) {
        newList.first.studentList?.remove(student);
        _refreshList();
      }
    }
  }

  void _refreshList() async {
    await _addStudentList();
    emit(ClassListLoadedState(
      studentWithClassList: studentWithClassList,
      schoolStatsList: schoolStatsList,
    ));
  }

  Future<void> _addStudentList() async {
    debugPrint("_addStudentList() çalıştı");
    schoolStatsList.clear();

    List<Student> fifthGradeStudentList = [];
    List<Student> sixthGradeStudentList = [];
    List<Student> seventhGradeStudentList = [];
    List<Student> eighthGradeStudentList = [];

    if (studentWithClassList != null) {
      for (var studentWithClass in studentWithClassList!) {
        if (studentWithClass.studentList != null &&
            studentWithClass.studentList!.isNotEmpty &&
            studentWithClass.classes.classLevel != null) {
          allStudentList.addAll(studentWithClass.studentList!);
          switch (studentWithClass.classes.classLevel) {
            case 5:
              fifthGradeStudentList.addAll(studentWithClass.studentList!);
              break;
            case 6:
              sixthGradeStudentList.addAll(studentWithClass.studentList!);
              break;
            case 7:
              seventhGradeStudentList.addAll(studentWithClass.studentList!);
              break;
            case 8:
              eighthGradeStudentList.addAll(studentWithClass.studentList!);
              break;
          }
        }
      }
    }

    schoolStatsList.add(
        SchoolStudentStats(classLevel: 5, classColor: Colors.redAccent, studentList: fifthGradeStudentList));

    schoolStatsList
        .add(SchoolStudentStats(classLevel: 6, classColor: Colors.lime, studentList: sixthGradeStudentList));

    schoolStatsList.add(SchoolStudentStats(
        classLevel: 7, classColor: Colors.lightBlue, studentList: seventhGradeStudentList));

    schoolStatsList.add(
        SchoolStudentStats(classLevel: 8, classColor: Colors.amber, studentList: eighthGradeStudentList));
  }
}
