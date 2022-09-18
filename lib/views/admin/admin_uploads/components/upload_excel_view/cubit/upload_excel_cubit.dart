import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

//import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/core/init/locale_manager.dart';
import 'package:rehberlik/core/init/pref_keys.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/student_repository.dart';

part 'upload_excel_state.dart';

class UploadExcelCubit extends Cubit<UploadExcelState> {
  UploadExcelCubit() : super(UploadExcelDefaultState());
  final ClassesRepository _classesRepository = locator<ClassesRepository>();
  final StudentRepository _studentRepository = locator<StudentRepository>();

  Map<String, List<Student>>? parsedStudentList;

  void addAllStudentListWithClass() async {
    emit(UploadExcelSavedState());
    final schoolID = SharedPrefs.instance.getString(PrefKeys.schoolID.toString());
    final studentList = parsedStudentList;
    if (studentList != null) {
      await _saveList(studentList, schoolID);
      emit(UploadExcelSavedState(isLoading: false));
    } else {
      emit(UploadExcelSavedState(isLoading: false, hasError: true));
    }
  }

  Future<void> _saveList(Map<String, List<Student>> studentList, String? schoolID) async {
    return studentList.forEach((key, list) async {
      //Sınıf ekle
      final className = key.toString();
      final classLevel = int.parse(className[0]);
      final classes = Classes(schoolID: schoolID, className: className, classLevel: classLevel);

      await _classesRepository.add(object: classes).then((classID) async {
        for (Student student in list) {
          student.classID = classID;
        }
        await _studentRepository.addAll(list: list);
      });
    });
  }

  // Excel Parse Methods
  Future<void> selectExcelFile({required bool isEokul}) async {
    /*
    _refreshList(isLoading: true);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result == null) {
      emit(UploadExcelDefaultState());
      return;
    } else {
      if (kIsWeb) {
        //Web
        final bytes = result.files.first.bytes;
        if (bytes != null) {
          parsedStudentList =
              isEokul ? await _decodeEokulFullExcelFile(bytes) : await _decodeTemplateExcelFile(bytes);

          _refreshList(isLoading: false);
        }
      } else {
        //Others
        final path = result.files.first.path;
        if (path != null) {
          var mobileBytes = await File(path).readAsBytes();
          parsedStudentList = isEokul
              ? await _decodeEokulFullExcelFile(mobileBytes)
              : await _decodeTemplateExcelFile(mobileBytes);

          _refreshList(isLoading: false);
        }
      }
    }
    */
  }

/*
  Future<Map<String, List<Student>>?> _decodeEokulFullExcelFile(Uint8List bytes) async {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    var decoder = Excel.decodeBytes(bytes);

    int i = 0;
    List<Student> studentList = [];
    Student student = Student();

    for (var table in decoder.tables.keys) {
      for (var row in decoder.tables[table]!.rows) {
        var data = row[4];
        var studentData = row[7];
        if (data != null) {
          if (i != 0 && i % 7 == 0) {
            studentList.add(student);
            student = Student();
            i = 0;
          }

          switch (i) {
            case 0:
              student.studentNumber = studentData?.value.toString();
              break;

            case 1:
              String className = fixItClassName(studentData?.value.toString());
              student.className = className;
              break;

            case 2:
              student.studentName = studentData?.value.toString();
              break;

            case 3:
              student.fatherName = studentData?.value.toString();
              break;

            case 4:
              student.motherName = studentData?.value.toString();
              break;

            case 5:
              student.gender = studentData?.value.toString();
              break;

            case 6:
              //var date = convertDigitsToDate(int.parse(studentData.toString()));
              var date = convertDateTime(studentData?.value.toString());
              student.birthDay = date;
              break;
          }

          i++;
        }
      }
    }

    final lastList = studentList.groupBy((student) => student.className!);
    final sortedList = SplayTreeMap<String, List<Student>>.from(lastList, (a, b) => a.compareTo(b));

    return sortedList;
  }

  Future<Map<String, List<Student>>?> _decodeTemplateExcelFile(Uint8List bytes) async {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    var decoder = Excel.decodeBytes(bytes);
    debugPrint("Tables ${decoder.tables.keys.toString()}");

    int i = 0;
    List<Student> studentList = [];

    for (var table in decoder.tables.keys) {
      for (var row in decoder.tables[table]!.rows) {
        var data = row[0];
        var studentData = row;
        if (data != null) {
          if (i != 0) {
            Student student = Student();
            student.studentNumber = studentData[0]?.value.toString();
            student.studentName = studentData[1]?.value;
            student.className = studentData[2]?.value;
            student.motherName = studentData[3]?.value;
            student.fatherName = studentData[4]?.value;
            student.motherPhone = studentData[5]?.value.toString();
            student.fatherPhone = studentData[6]?.value.toString();
            student.birthDay = studentData[7]?.value;
            student.gender = studentData[8]?.value;

            studentList.add(student);
          }

          i++;
        }
      }
    }

    final lastList = studentList.groupBy((student) => student.className!);
    final sortedList = SplayTreeMap<String, List<Student>>.from(lastList, (a, b) => a.compareTo(b));

    return sortedList;
  }

*/
  String fixItClassName(String? className) {
    if (className != null) {
      const first = ". Sınıf / ";
      const second = " Şubesi";
      const third = ". Sınıf (Yabancı Dil Ağırlıklı) / ";
      var firstManipulatedClassName = className.replaceAll(first, "-");
      var secondManipulatedClassName = firstManipulatedClassName.replaceAll(third, "-");
      className = secondManipulatedClassName.replaceAll(second, "");
      return className;
    } else {
      return "";
    }
  }

  String? convertDateTime(String? date) {
    if (date != null) {
      var convertedDate = DateTime.parse(date);
      var formatedDate = DateFormat("dd.MM.yyyy").format(convertedDate);

      return formatedDate;
    }

    return null;
  }

  void _refreshList({required bool isLoading}) {
    emit(UploadExcelParsedState(isLoading: isLoading, parsedStudentList: parsedStudentList));
  }
}
