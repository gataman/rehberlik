// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String?,
      classID: json['classID'] as String?,
      classLevel: json['classLevel'] as int?,
      studentName: json['studentName'] as String?,
      studentNumber: json['studentNumber'] as String?,
      fatherName: json['fatherName'] as String?,
      motherName: json['motherName'] as String?,
      gender: json['gender'] as String?,
      birthDay: json['birthDay'] as String?,
      photoUrl: json['photoUrl'] as String?,
      fatherPhone: json['fatherPhone'] as String?,
      motherPhone: json['motherPhone'] as String?,
      className: json['className'] as String?,
      targetSchoolID: json['targetSchoolID'] as String?,
      password: json['password'] as String?,
      tcKimlik: json['tcKimlik'] as String?,
      salonNo: json['salonNo'] as String?,
      siraNo: json['siraNo'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'classID': instance.classID,
      'classLevel': instance.classLevel,
      'studentName': instance.studentName,
      'studentNumber': instance.studentNumber,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'gender': instance.gender,
      'birthDay': instance.birthDay,
      'photoUrl': instance.photoUrl,
      'fatherPhone': instance.fatherPhone,
      'motherPhone': instance.motherPhone,
      'className': instance.className,
      'targetSchoolID': instance.targetSchoolID,
      'password': instance.password,
      'tcKimlik': instance.tcKimlik,
      'salonNo': instance.salonNo,
      'siraNo': instance.siraNo,
    };
