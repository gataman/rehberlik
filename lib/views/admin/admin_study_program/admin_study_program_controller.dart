import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/repository/study_program_repository.dart';

class AdminStudyProgramController extends GetxController {
  //region Properties
  final _studyProgramRepository = Get.put(StudyProgramRepository());
  List<StudyProgram>? localProgramList;
  String? studentID;
  //endregion

  //region StudyProgram List
  final list = <StudyProgram>[
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 7, 15),
      turTarget: 10,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 07, 16),
      turTarget: 10,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 07, 17),
      turTarget: 10,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 07, 18),
      turTarget: 10,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 7, 27),
      turTarget: 27,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 7, 28),
      turTarget: 28,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
    StudyProgram(
      studentID: "4Vmdx0gLlcN8N0qaB1PB",
      date: DateTime(2022, 7, 29),
      turTarget: 29,
      turSolved: 11,
      turCorrect: 12,
      turIncorrect: 13,
      matTarget: 20,
      matSolved: 21,
      matCorrect: 22,
      matIncorrect: 23,
      fenTarget: 30,
      fenSolved: 31,
      fenCorrect: 32,
      fenIncorrect: 33,
      inkTarget: 40,
      inkSolved: 41,
      inkCorrect: 42,
      inkIncorrect: 43,
      ingTarget: 50,
      ingSolved: 51,
      ingCorrect: 52,
      ingIncorrect: 53,
      dinTarget: 60,
      dinSolved: 61,
      dinCorrect: 62,
      dinIncorrect: 63,
    ),
  ];

  //endregion

  //region Methods
  Future<List<StudyProgram>?> getAllPrograms(
      {required String studentID, required DateTime startTime}) async {
    if (localProgramList == null) {
      debugPrint("Get all programs çalıştı..........");
      localProgramList = <StudyProgram>[];
      for (var i = 0; i < 7; i++) {
        final _date = startTime.add(Duration(days: i));
        final _studyProgram = StudyProgram(studentID: studentID, date: _date);
        localProgramList!.add(_studyProgram);
      }

      final endTime = startTime.add(const Duration(days: 6));

      var _remoteList = await _studyProgramRepository.getAll(
          studentID: studentID, startTime: startTime, endTime: endTime);

      if (_remoteList != null && _remoteList.isNotEmpty) {
        var i = 0;
        for (var _localProgram in localProgramList!) {
          var findingProgram = _remoteList.firstWhereOrNull(
              (element) => element.date == _localProgram.date);
          if (findingProgram != null) {
            localProgramList![i] = findingProgram;
          }
          i++;
        }
      }
    }
    return localProgramList;
  }

  void addAllProgram() {
    _studyProgramRepository.addAll(list: list);
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
