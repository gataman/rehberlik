import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/models/trial_exam_result.dart';
import 'package:rehberlik/repository/trial_exam_result_repository.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';

class AdminTrialExamResultController extends AdminBaseController {
  final TrialExam trialExam;
  final _trialExamResultRepository = Get.put(TrialExamResultRepository());

  AdminTrialExamResultController({required this.trialExam});

  Rxn<List<TrialExamResult>?> trialExamResultList =
      Rxn<List<TrialExamResult>?>();

  @override
  void onInit() {
    getAllTrialExamDetail(trialExamID: trialExam.id!);
    super.onInit();
  }

  void getAllTrialExamDetail({required String trialExamID}) async {
    final list = await _trialExamResultRepository
        .getAll(filters: {'examID': trialExamID});
    trialExamResultList.value = list;
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
    var decoder = Excel.decodeBytes(bytes);
    debugPrint(decoder.tables.keys.toString());
  }
}
