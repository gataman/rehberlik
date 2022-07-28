import 'package:flutter/material.dart';
import 'package:rehberlik/models/meetings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meetings> meetings) {
    appointments = meetings;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from!;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to!;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName!;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background!;
  }

  Meetings _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meetings meetingData;
    if (meeting is Meetings) {
      meetingData = meeting;
    }

    return meetingData;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) {
    debugPrint("start time : $startDate");
    return super.handleLoadMore(startDate, endDate);
  }
}
