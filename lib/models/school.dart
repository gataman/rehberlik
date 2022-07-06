import 'package:cloud_firestore/cloud_firestore.dart';

class School {
  final String? id;
  String? schoolName;

  School({this.id, required this.schoolName});

  factory School.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return School(
      id: snapshot.id,
      schoolName: data?['schoolName'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (schoolName != null) "schoolName": schoolName,
    };
  }

  @override
  String toString() {
    return 'School{id: $id, schoolName: $schoolName}';
  }
}
