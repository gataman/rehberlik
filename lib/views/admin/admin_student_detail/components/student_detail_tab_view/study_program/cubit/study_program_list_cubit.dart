import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/extensions.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/study_program.dart';
import 'package:rehberlik/repository/study_program_repository.dart';

part 'study_program_list_state.dart';

class StudyProgramListCubit extends Cubit<StudyProgramListState> {
  StudyProgramListCubit() : super(StudyProgramListState());

  final StudyProgramRepository _studyProgramRepository = locator<StudyProgramRepository>();
  List<StudyProgram>? studyProgramList;

  Future<List<StudyProgram>?> fetchStudyProgramList({required String studentID, DateTime? startTime}) async {
    if (startTime == null) {
      final dateNow = DateTime.now();
      startTime = DateTime(dateNow.year, dateNow.month, dateNow.day);
    }

    final localList = <StudyProgram>[];
    for (var i = 0; i < 7; i++) {
      final date = startTime.add(Duration(days: i));
      final studyProgram = StudyProgram(studentID: studentID, date: date);
      localList.add(studyProgram);
    }

    final endTime = startTime.add(const Duration(days: 6));

    var _remoteList =
        await _studyProgramRepository.getAll(studentID: studentID, startTime: startTime, endTime: endTime);

    if (_remoteList != null && _remoteList.isNotEmpty) {
      var i = 0;
      for (var _localProgram in localList) {
        var findingProgram = _remoteList.findOrNull((element) => element.date == _localProgram.date);
        if (findingProgram != null) {
          localList[i] = findingProgram;
        }
        i++;
      }
    }

    studyProgramList = localList;
    _refreshList();
    return studyProgramList;
  }

  Future<String?> changeProgram({required StudyProgram studyProgram}) async {
    if (studyProgram.id == null) {
      return await _studyProgramRepository.add(object: studyProgram);
    } else {
      _studyProgramRepository.update(object: studyProgram);
      return null;
    }
  }

  void _refreshList() {
    emit(StudyProgramListState(isLoading: false, studyProgramList: studyProgramList));
  }
}
