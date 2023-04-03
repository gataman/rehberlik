import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../models/meeting.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting>? meetings) {
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

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) {
    return super.handleLoadMore(startDate, endDate);
  }
}
