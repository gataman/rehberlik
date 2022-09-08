import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import '../../../models/trial_exam.dart';
import '../../../models/trial_exam_result.dart';
import '../../../repository/trial_exam_result_repository.dart';

/*
class AdminTrialExamResultController extends AdminBaseController {
  final _trialExamResultRepository = Get.put(TrialExamResultRepository());
  TrialExam? selectedTrialExam;

  final RxList<TrialExamResult> trialExamResultList = RxList();

  void getAllTrialExamDetail() async {
    if (selectedTrialExam != null) {
      debugPrint("ListeResult ${selectedTrialExam!.id.toString()}");
      final list = await _trialExamResultRepository.getAll(filters: {'examID': selectedTrialExam!.id!});
      if (list != null) {
        debugPrint("Liste ID ${list.hashCode}");
        trialExamResultList.clear();
        trialExamResultList.addAll(list);
      }
    }
  }

  Future<void> selectExcelFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result == null) {
      return;
    } else {
      if (kIsWeb) {
        final bytes = result.files.first.bytes;
        if (bytes != null) {
          _decodeExcelFile(bytes);
        } else {
          return;
        }
      } else {
        final path = result.files.first.path;
        if (path != null) {
          var mobileBytes = await File(path).readAsBytes();
          _decodeExcelFile(mobileBytes);
        } else {
          return;
        }
      }
    }
  }

  void _decodeExcelFile(Uint8List bytes) {
    // var decoder = Excel.decodeBytes(bytes);
  }
}

 */
