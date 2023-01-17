import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  String? id;
  String? lessonID;
  String? subject;
  int? sort;

  Subject({this.id, required this.lessonID, required this.subject, required this.sort});

  factory Subject.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Subject(id: snapshot.id, lessonID: data?['lessonID'], subject: data?['subject'], sort: data?['sort']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (lessonID != null) "lessonID": lessonID,
      if (subject != null) "subject": subject,
      "sort": sort,
    };
  }

  @override
  String toString() {
    return 'Subject{id: $id, lessonID: $lessonID, subject: $subject, sort: $sort}';
  }
}
