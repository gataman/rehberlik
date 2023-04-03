import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_excel/excel.dart';
import '../../../../../../common/extensions.dart';
import '../../../../../../common/locator.dart';
import '../../../../../../models/student.dart';
import '../../../../../../models/student_with_class.dart';
import '../../../../../../repository/classes_repository.dart';
import '../../../../../../repository/student_repository.dart';

part 'upload_tc_state.dart';

class UploadTcCubit extends Cubit<UploadTcState> {
  UploadTcCubit() : super(UploadExcelDefaultState());
  final ClassesRepository _classesRepository = locator<ClassesRepository>();
  final StudentRepository _studentRepository = locator<StudentRepository>();

  List<Student>? parsedStudentList;

  // Excel Parse Methods
  Future<void> selectExcelFile({required List<Student> studentList}) async {
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
          parsedStudentList = await _decodeExcelFile(bytes, studentList);

          _refreshList(isLoading: false);
        }
      } else {
        //Others
        final path = result.files.first.path;
        if (path != null) {
          var mobileBytes = await File(path).readAsBytes();
          parsedStudentList = await _decodeExcelFile(mobileBytes, studentList);

          _refreshList(isLoading: false);
        }
      }
    }
  }

  Future<List<Student>?> _decodeExcelFile(Uint8List bytes, List<Student> list) async {
    //final decoder = SpreadsheetDecoder.decodeBytes(bytes, update: false);
    var decoder = Excel.decodeBytes(bytes);

    int i = 0;
    List<Student> studentList = [];

    for (var table in decoder.tables.keys) {
      for (var row in decoder.tables[table]!.rows) {
        var data = row[0];
        var studentData = row;
        if (data != null) {
          if (i != 0) {
            final studentNo = studentData[0]?.value.toString();
            final salonNo = studentData[1]?.value.toString();
            final siraNo = studentData[2]?.value.toString();
            final tcKimlik = studentData[3]?.value.toString();

            final findingStudent =
                list.findOrNull((element) => element.studentNumber.toString() == studentNo.toString());

            if (findingStudent != null) {
              findingStudent.tcKimlik = tcKimlik;
              findingStudent.siraNo = siraNo;
              findingStudent.salonNo = salonNo;
              studentList.add(findingStudent);
            }
          }

          i++;
        }
      }
    }
    return studentList;
  }

  void _refreshList({required bool isLoading}) {
    emit(UploadTcParsedState(isLoading: isLoading, parsedStudentList: parsedStudentList));
  }
}
