import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/models/school_student_stats.dart';
import 'package:rehberlik/models/meetings.dart';
import 'package:rehberlik/repository/meeting_repository.dart';
import 'package:rehberlik/repository/school_repository.dart';

class AdminDashboardController extends GetxController {
  final _box = GetStorage();
  final _meetingRepository = Get.put(MeetingReposityory());
  final _schoolRepository = Get.put(SchoolRepository());

  Rxn<List<Meetings>> meetingList = Rxn<List<Meetings>>();
  Rxn<TimeOfDay> startTime = Rxn<TimeOfDay>();
  Rxn<TimeOfDay> endTime = Rxn<TimeOfDay>();
  Rxn<List<SchoolStudentStats>?> schoolStudentStatsList =
      Rxn<List<SchoolStudentStats>>();

  var meetingTypeIndex = 0.obs;

  void addMeeting(Meetings object) {
    _meetingRepository.add(object: object).then((value) {
      object.id = value;
      object.background = _getBackgroundColor(object.type!);
      var _meetingList = meetingList.value;
      _meetingList ??= <Meetings>[];
      _meetingList.add(object);
      meetingList.refresh();
    });
  }

  void getAllMeetings() {
    _meetingRepository.getAll().then((_meetingList) {
      meetingList.value = _meetingList;
    });
  }

  void getAllMeetingsWithTime(DateTime startTime, DateTime endTime) {
    _meetingRepository
        .getAllWithTime(startTime: startTime, endTime: endTime)
        .then((_meetingList) {
      meetingList.value = _meetingList;
    });
  }

  Color _getBackgroundColor(int i) {
    switch (i) {
      case 1:
        return meetingParentColor;
      case 2:
        return meetingConferenceColor;
      case 3:
        return meetingOthersColor;
      default:
        return meetingStudentColor;
    }
  }

  Future<void> deleteMeeting(Meetings meetings) async {
    return await _meetingRepository
        .delete(objectID: meetings.id!)
        .then((value) {
      meetingList.value!.remove(meetings);
      meetingList.refresh();
    });
  }

  void getSchoolStudentStats() {
    final List<SchoolStudentStats> _schoolStudentStatsList = [
      SchoolStudentStats(classLevel: 5, classColor: Colors.redAccent),
      SchoolStudentStats(classLevel: 6, classColor: Colors.lime),
      SchoolStudentStats(classLevel: 7, classColor: Colors.lightBlue),
      SchoolStudentStats(classLevel: 8, classColor: Colors.amber),
    ];
    schoolStudentStatsList.value = _schoolStudentStatsList;
    final schoolID = _box.read("schoolID");

    for (var schoolStats in _schoolStudentStatsList) {
      _schoolRepository
          .getStudentCount(
              schoolID: schoolID, classLevel: schoolStats.classLevel)
          .then((count) {
        schoolStats.studentCount = count;
        schoolStudentStatsList.refresh();
      });
    }
  }
}
