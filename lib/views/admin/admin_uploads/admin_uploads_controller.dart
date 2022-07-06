import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rehberlik/common/custom_result.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/models/classes.dart';
import 'package:rehberlik/models/student.dart';
import 'package:flutter/foundation.dart';
import 'package:rehberlik/repository/classes_repository.dart';
import 'package:rehberlik/repository/student_repository.dart';

class AdminUploadsController extends GetxController {
  final _studentRepository = Get.put(StudentRepository());
  final _classesRepository = Get.put(ClassesRepository());
  final box = Get.put(GetStorage());

  Rxn<Map<String, List<Student>>> parsedStudentList =
      Rxn<Map<String, List<Student>>>();

  Rxn<CustomResult> addAllStudentResult = Rxn<CustomResult>();

  //CRUD Methods
  void addAllStudentListWithClass() async {
    var studentAddAllResult = CustomResult(
      isSuccess: false,
      message: "Öğrenci Yükleme İşlemi başladı",
      isLoading: true,
    );

    addAllStudentResult.value = studentAddAllResult;

    final schoolID = box.read("schoolID");
    final studentList = parsedStudentList.value;
    if (studentList != null) {
      studentList.forEach((key, list) {
        //Sınıf ekle
        final className = key.toString();
        final classLevel = int.parse(className[0]);
        final classes = Classes(
            schoolID: schoolID, className: className, classLevel: classLevel);

        _classesRepository.add(object: classes).then((classID) {
          for (Student student in list) {
            student.classID = classID;
          }
          _studentRepository.addAll(list: list).then((value) {
            studentAddAllResult.isLoading = false;
            studentAddAllResult.isSuccess = true;
            studentAddAllResult.message = "Kayıt işlemi tamamlandı";
            addAllStudentResult.value = studentAddAllResult;
          });
        });
      });
    }
  }

  // Excel Parse Methods
  Future<void> selectExcelFile({required bool isEokul}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result == null) {
      return;
    } else {
      if (kIsWeb) {
        //Web
        final bytes = result.files.first.bytes;
        if (bytes != null) {
          parsedStudentList.value = isEokul
              ? await _decodeEokulFullExcelFile(bytes)
              : await _decodeTemplateExcelFile(bytes);
        }
      } else {
        //Others
        final path = result.files.first.path;
        if (path != null) {
          var mobileBytes = await File(path).readAsBytes();
          parsedStudentList.value = isEokul
              ? await _decodeEokulFullExcelFile(mobileBytes)
              : await _decodeTemplateExcelFile(mobileBytes);
        }
      }
    }
  }

  Future<Map<String, List<Student>>?> _decodeEokulFullExcelFile(
      Uint8List bytes) async {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    var decoder = Excel.decodeBytes(bytes);
    debugPrint(decoder.tables.keys.toString());

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
    final sortedList = SplayTreeMap<String, List<Student>>.from(
        lastList, (a, b) => a.compareTo(b));

    return sortedList;
  }

  Future<Map<String, List<Student>>?> _decodeTemplateExcelFile(
      Uint8List bytes) async {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    var decoder = Excel.decodeBytes(bytes);
    debugPrint(decoder.tables.keys.toString());

    int i = 0;
    List<Student> studentList = [];

    for (var table in decoder.tables.keys) {
      for (var row in decoder.tables[table]!.rows) {
        var data = row[0];
        debugPrint("Gelen Data ${data.toString()}");
        var studentData = row;
        if (data != null) {
          if (i != 0) {
            Student student = Student();
            student.studentNumber = studentData[0]?.value.toString();
            student.studentName = studentData[1]?.value;
            student.className = studentData[2]?.value;
            student.motherName = studentData[3]?.value;
            student.fatherName = studentData[4]?.value;
            student.motherPhone = studentData[5]?.value;
            student.fatherPhone = studentData[6]?.value;
            student.birthDay = studentData[7]?.value;
            student.gender = studentData[8]?.value;

            studentList.add(student);
          }

          i++;
        }
      }
    }

    final lastList = studentList.groupBy((student) => student.className!);
    final sortedList = SplayTreeMap<String, List<Student>>.from(
        lastList, (a, b) => a.compareTo(b));

    return sortedList;
  }

  String fixItClassName(String? className) {
    if (className != null) {
      const first = ". Sınıf / ";
      const second = " Şubesi";
      const third = ". Sınıf (Yabancı Dil Ağırlıklı) / ";
      var firstManipulatedClassName = className.replaceAll(first, "-");
      var secondManipulatedClassName =
          firstManipulatedClassName.replaceAll(third, "-");
      var _className = secondManipulatedClassName.replaceAll(second, "");
      return _className;
    } else {
      return "";
    }
  }

  String convertDigitsToDate(int excelDate) {
    const convertExcelDateToMillis = 86400000;
    var excelStartTime = 2208995816000 + 172800000; //2209168616000
    var totalMilis = (excelDate * convertExcelDateToMillis) - excelStartTime;
    var date = DateTime.fromMillisecondsSinceEpoch(totalMilis);

    var dateText = "${date.day}/${date.month}/${date.year}";
    return dateText;
  }

  String? convertDateTime(String? date) {
    if (date != null) {
      var convertedDate = DateTime.parse(date);
      var formatedDate = DateFormat("dd.MM.yyyy").format(convertedDate);

      return formatedDate;
    }

    return null;
  }

  // Total Image
  Future<void> selectAllStudentImage() async {
    //final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage(maxWidth: 256);
    if (images != null) {
      var totalImagesCount = images.length.toDouble();
      var studentImageResult = CustomResult(
          isSuccess: false,
          message:
              "Öğrenci fotoğrafları yükleme işlemi başlatıldı. Bu işlem uzun sürebilir...",
          isLoading: true,
          hasLinearProgress: true);

      addAllStudentResult.value = studentImageResult;

      List<Student> studentList = await _studentRepository.getAllWithSchoolID(
          schoolID: "w7WZvgcVPKVheXnhxMHE");

      List<Student> editingStudentList = <Student>[];

      int linearValue = 0;

      for (var studentImage in images) {
        final studentNumber =
            studentImage.name.split(".")[0].replaceAll("scaled_", "");

        var studentSearchList = studentList
            .where((element) => element.studentNumber == studentNumber);
        if (studentSearchList.isNotEmpty) {
          Student student = studentSearchList.first;

          await _studentRepository
              .uploadStudentImage(
                  imageFile: studentImage,
                  schoolID: "w7WZvgcVPKVheXnhxMHE",
                  imageFileName: "$studentNumber.jpeg")
              .then((imageUrl) {
            student.photoUrl = imageUrl;
            editingStudentList.add(student);
          });
          linearValue++;

          addAllStudentResult.value = CustomResult(
              isSuccess: false,
              isLoading: true,
              message:
                  "Öğrenci fotoğrafları yükleme yükleniyor. Yüklenen fotoğraf sayısı: $linearValue",
              hasLinearProgress: true,
              linearValue: linearValue.toDouble() / totalImagesCount);
        } else {
          debugPrint("Bu numara bulunamadı : $studentNumber");
        }
      }

      await _studentRepository.updateAll(list: editingStudentList);
      addAllStudentResult.value =
          CustomResult(message: "İşlem başarıyla gerçekleşti");
    }
  }
}
