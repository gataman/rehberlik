import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/trial_exam.dart';
import 'package:rehberlik/models/trial_exam_result.dart';
import 'package:rehberlik/repository/trial_exam_repository.dart';
import 'package:rehberlik/repository/trial_exam_result_repository.dart';
import 'package:rehberlik/views/admin/admin_base_controller.dart';

class AdminTrialExamController extends AdminBaseController {
  final _trialExamRepository = Get.put(TrialExamRepository());
  final _trialExamResultRepository = Get.put(TrialExamResultRepository());
  var selectedClassLevel = 5;
  Rxn<List<TrialExam>?> trialExamList = Rxn<List<TrialExam>?>();
  final editingTrialExam = Rxn<TrialExam>();
  final statusAddingTrialExam = false.obs;
  final statusOpeningDialog = false.obs;

  @override
  void onInit() {
    debugPrint(
        "AdminTrialExamController on init çalıştı ${selectedClassLevel.toString()}");
    getAllTrialExam(classLevel: selectedClassLevel);
    super.onInit();
  }

  void addTrialExam() {
    TrialExam exam = TrialExam(
        examName: 'Hız Yayınları 1',
        examCode: 'Hız1',
        classLevel: 5,
        examDate: DateTime.now(),
        examType: 1);
    _trialExamRepository.add(object: exam).then((value) {
      debugPrint("Başarıyla kaydedildi");
    });
  }

  void addAllTrialExamResult({required List<TrialExamResult> resultList}) {
    _trialExamResultRepository.addAll(list: resultList).then((value) {
      debugPrint("Başarıyla kaydedildi");
    }, onError: (e) {
      debugPrint("Hata ${e.toString()}");
    });
  }

  void getAllTrialExam({required int classLevel}) async {
    selectedClassLevel = classLevel;
    final _remoteList =
        await _trialExamRepository.getAll(filters: {'classLevel': classLevel});
    trialExamList.value = _remoteList;

    debugPrint("Get all trial exam çalıştı");
  }
}
