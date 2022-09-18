import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String? id;
  int? classLevel;
  String? lessonName;
  int? lessonTime;
  String? schoolID;

  Lesson(
      {this.id, required this.classLevel, required this.lessonName, required this.lessonTime, required this.schoolID});

  factory Lesson.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Lesson(
      id: snapshot.id,
      classLevel: data?['classLevel'],
      lessonName: data?['lessonName'],
      lessonTime: data?['lessonTime'],
      schoolID: data?['schoolID'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (classLevel != null) "classLevel": classLevel,
      if (lessonName != null) "lessonName": lessonName,
      if (lessonTime != null) "lessonTime": lessonTime,
      if (schoolID != null) "schoolID": schoolID,
    };
  }

  @override
  String toString() {
    return 'Lesson{id: $id, classLevel: $classLevel, lessonName: $lessonName, lessonTime: $lessonTime, schholID: $schoolID}';
  }
}
