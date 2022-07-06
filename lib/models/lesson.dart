import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  final String? id;
  String? classID;
  String? lessonName;
  int? lessonTime;

  Lesson(
      {this.id,
      required this.classID,
      required this.lessonName,
      required this.lessonTime});

  factory Lesson.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Lesson(
      id: snapshot.id,
      classID: data?['classID'],
      lessonName: data?['lessonName'],
      lessonTime: data?['lessonTime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (classID != null) "classID": classID,
      if (lessonName != null) "lessonName": lessonName,
      if (lessonTime != null) "lessonTime": lessonTime,
    };
  }

  @override
  String toString() {
    return 'Lesson{id: $id, classID: $classID, lessonName: $lessonName, lessonTime: $lessonTime}';
  }
}
