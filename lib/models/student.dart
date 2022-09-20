import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../core/init/locale_manager.dart';
import '../core/init/pref_keys.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String? id;
  String? classID;
  String? studentName;
  String? studentNumber;
  String? fatherName;
  String? motherName;
  String? gender;
  String? birthDay;
  String? photoUrl;
  String? fatherPhone;
  String? motherPhone;
  String? className;
  String? targetSchoolID;
  String? password;

  Student({
    this.id,
    this.classID,
    this.studentName,
    this.studentNumber,
    this.fatherName,
    this.motherName,
    this.gender,
    this.birthDay,
    this.photoUrl,
    this.fatherPhone,
    this.motherPhone,
    this.className,
    this.targetSchoolID,
    this.password,
  });

  factory Student.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Student(
      id: snapshot.id,
      classID: data?['classID'],
      studentName: data?['studentName'],
      studentNumber: data?['studentNumber'],
      fatherName: data?['fatherName'],
      motherName: data?['motherName'],
      gender: data?['gender'],
      birthDay: data?['birthDay'],
      photoUrl: data?['photoUrl'],
      fatherPhone: data?['fatherPhone'],
      motherPhone: data?['motherPhone'],
      className: data?['className'],
      targetSchoolID: data?['targetSchoolID'],
      password: data?['password'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (classID != null) "classID": classID,
      if (studentName != null) "studentName": studentName,
      if (studentNumber != null) "studentNumber": studentNumber,
      if (fatherName != null) "fatherName": fatherName,
      if (motherName != null) "motherName": motherName,
      if (gender != null) "gender": gender,
      if (birthDay != null) "birthDay": birthDay,
      if (photoUrl != null) "photoUrl": photoUrl,
      if (fatherPhone != null) "fatherPhone": fatherPhone,
      if (motherPhone != null) "motherPhone": motherPhone,
      if (className != null) "className": className,
      if (targetSchoolID != null) "targetSchoolID": targetSchoolID,
      "password": password,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  @override
  String toString() {
    return 'Student{id: $id, classID: $classID, studentName: $studentName, studentNumber: $studentNumber, fatherName: $fatherName, motherName: $motherName, gender: $gender, birthDay: $birthDay, photoUrl: $photoUrl, fatherPhone: $fatherPhone, motherPhone: $motherPhone, className: $className, targetSchoolID: $targetSchoolID,password: $password}';
  }

  static Student? getStudentFormLocal() {
    final studentPref = SharedPrefs.instance.getString(PrefKeys.student.toString());
    if (studentPref != null) {
      return Student.fromJson(jsonDecode(studentPref));
    } else {
      return null;
    }
  }
}
