import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../common/constants.dart';

class Meeting {
  String? id;
  String? eventName;
  DateTime? from;
  DateTime? to;
  int? type;
  Color? background;

  Meeting(
      {this.id,
      required this.eventName,
      required this.from,
      required this.to,
      required this.type,
      this.background = Colors.redAccent});

  factory Meeting.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Meeting(
        id: snapshot.id,
        eventName: data?['eventName'],
        from: (data?['from'] as Timestamp).toDate(),
        to: (data?['to'] as Timestamp).toDate(),
        type: data?['type'],
        background: data?['type'] == 0
            ? meetingStudentColor
            : data?['type'] == 1
                ? meetingParentColor
                : data?['type'] == 2
                    ? meetingConferenceColor
                    : meetingOthersColor);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (eventName != null) "eventName": eventName,
      if (from != null) "from": from,
      if (to != null) "to": to,
      if (type != null) "type": type,
    };
  }

  @override
  String toString() {
    return 'Meetings{id: $id, eventName: $eventName, from: $from, to: $to, type: $type, background: $background}';
  }
}
