import 'package:cloud_firestore/cloud_firestore.dart';

class Classes {
  final String? id;
  String? schoolID;
  String? className;
  int? classLevel;

  Classes(
      {this.id,
      required this.schoolID,
      required this.className,
      required this.classLevel});

  factory Classes.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Classes(
      id: snapshot.id,
      schoolID: data?['schoolID'],
      className: data?['className'],
      classLevel: data?['classLevel'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (schoolID != null) "schoolID": schoolID,
      if (className != null) "className": className,
      if (classLevel != null) "classLevel": classLevel,
    };
  }

  @override
  String toString() {
    return 'Classes{id: $id, schoolID: $schoolID, className: $className, classLevel: $classLevel}';
  }
}
