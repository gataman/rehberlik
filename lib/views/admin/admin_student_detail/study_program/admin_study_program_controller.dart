import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/repository/study_program_repository.dart';

class AdminStudyProgramController extends GetxController {
  //region Properties
  final _studyProgramRepository = Get.put(StudyProgramRepository());

  Rxn<List<StudyProgram>?> programList = Rxn<List<StudyProgram>?>();
  var startTimeChanged = false.obs;

  //endregion

  //region Methods
  Future<List<StudyProgram>> getAllPrograms(
      {required String studentID, DateTime? startTime}) async {
    if (startTime == null) {
      final _dateNow = DateTime.now();
      startTime = DateTime(_dateNow.year, _dateNow.month, _dateNow.day);
    }

    final _localList = <StudyProgram>[];
    for (var i = 0; i < 7; i++) {
      final _date = startTime.add(Duration(days: i));
      final _studyProgram = StudyProgram(studentID: studentID, date: _date);
      _localList.add(_studyProgram);
    }

    final endTime = startTime.add(const Duration(days: 6));

    var _remoteList = await _studyProgramRepository.getAll(
        studentID: studentID, startTime: startTime, endTime: endTime);

    if (_remoteList != null && _remoteList.isNotEmpty) {
      var i = 0;
      for (var _localProgram in _localList) {
        var findingProgram = _remoteList
            .firstWhereOrNull((element) => element.date == _localProgram.date);
        if (findingProgram != null) {
          _localList[i] = findingProgram;
        }
        i++;
      }
    }

    programList.value = _localList;
    programList.refresh();
    return _localList;
  }

  Future<String?> changeProgram({required StudyProgram studyProgram}) async {
    if (studyProgram.id == null) {
      return await _studyProgramRepository.add(object: studyProgram);
    } else {
      _studyProgramRepository.update(object: studyProgram);
      return null;
    }
  }

//endregion

}
