import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTable {
  String? id;
  String? studentID;
  int order;
  int day;
  int? startTime;
  int? endTime;
  String? lessonID;
  String? subjectID;

  TimeTable(
      {this.id,
      this.studentID,
      this.order = 0,
      this.day = 1,
      this.startTime,
      this.endTime,
      this.lessonID,
      this.subjectID});

  factory TimeTable.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TimeTable(
      id: snapshot.id,
      studentID: data?['studentID'],
      order: data?['order'],
      day: data?['day'],
      startTime: data?['startTime'],
      endTime: data?['endTime'],
      lessonID: data?['lessonID'],
      subjectID: data?['subjectID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (studentID != null) "studentID": studentID,
      "order": order,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "lessonID": lessonID,
      "subjectID": subjectID
    };
  }

  @override
  String toString() {
    return 'TimeTable{id: $id, studentID: $studentID, order: $order, day: $day, startTime: $startTime, endTime: $endTime, lessonID: $lessonID, subjectID: $subjectID}';
  }
}
