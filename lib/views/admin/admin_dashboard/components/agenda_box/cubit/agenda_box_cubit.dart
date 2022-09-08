import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:rehberlik/models/meeting.dart';
import 'package:rehberlik/repository/meeting_repository.dart';

part 'agenda_box_state.dart';

class AgendaBoxCubit extends Cubit<AgendaBoxState> {
  AgendaBoxCubit() : super(AgendaBoxInitial());

  List<Meeting>? meetingList;

  final MeetingReposityory _meetingRepository = locator<MeetingReposityory>();

  void fetchAllMeetings() async {
    final list = await _meetingRepository.getAll();
    meetingList = list;
    _refreshList();
  }

  void fetchAllMeetingsWithTime(DateTime startTime, DateTime endTime) async {
    final list = await _meetingRepository.getAllWithTime(startTime: startTime, endTime: endTime);
    meetingList = list;
    _refreshList();
  }

  void addMeeting(Meeting object) {
    _meetingRepository.add(object: object).then((value) {
      object.id = value;
      object.background = _getBackgroundColor(object.type!);

      meetingList ??= <Meeting>[];
      meetingList!.add(object);
      _refreshList();
    });
  }

  Future<void> deleteMeeting(Meeting meetings) async {
    return await _meetingRepository.delete(objectID: meetings.id!).then((value) {
      meetingList?.remove(meetings);
      _refreshList();
    });
  }

  void _refreshList() {
    emit(AgendaBoxInitial(meetingList: meetingList, isLoading: false));
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
}
