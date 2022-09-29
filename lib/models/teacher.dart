import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../core/init/locale_manager.dart';
import '../core/init/pref_keys.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final String? id;
  String? email;
  String? name;
  String? photoUrl;
  int rank;

  Teacher({this.id, this.email, this.name, this.photoUrl, this.rank = 2});

  factory Teacher.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Teacher(
      id: snapshot.id,
      email: data?['email'],
      name: data?['name'],
      photoUrl: data?['photoUrl'],
      rank: data?['rank'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      'photoUrl': photoUrl,
      'rank': rank,
    };
  }

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  @override
  String toString() {
    return 'Teacher{id: $id, email: $email, name: $name, photoUrl: $photoUrl, rank: $rank}';
  }

  static Teacher? getTeacherFormLocal() {
    final teacherPref = SharedPrefs.instance.getString(PrefKeys.teacher.toString());
    if (teacherPref != null) {
      return Teacher.fromJson(jsonDecode(teacherPref));
    } else {
      return null;
    }
  }
}
