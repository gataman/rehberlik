import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/common/constants.dart';

class Meetings {
  String? id;
  String? eventName;
  DateTime? from;
  DateTime? to;
  int? type;
  Color? background;

  Meetings(
      {this.id,
      required this.eventName,
      required this.from,
      required this.to,
      required this.type,
      this.background = Colors.redAccent});

  factory Meetings.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Meetings(
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
