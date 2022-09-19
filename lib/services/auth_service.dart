import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../common/models/student_login_result.dart';
import '../models/student.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<UserCredential> teacherLogin({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
    /*
    try {
      final credential =  _auth.signInWithEmailAndPassword(email: email, password: password);


      debugPrint(credential.toString());
      debugPrint(credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    */
  }

  Future<StudentLoginResult> studentLogin({required String number, required String password}) async {
    var colRef = _db
        .collection('students')
        .where('studentNumber', isEqualTo: number)
        .withConverter(fromFirestore: Student.fromFirestore, toFirestore: (Student object, _) => object.toFirestore());

    final docSnap = await colRef.get();
    final list = docSnap.docs.map((e) => e.data()).toList();
    if (list.isNotEmpty) {
      final Student student = list.first;
      debugPrint("Öğrenci ${student.toString()}");
      if (student.password == password) {
        return StudentLoginResult(message: 'Başarıyla giriş yapıldı!', isSuccess: true, student: student);
      } else {
        return StudentLoginResult(message: 'Lütfen şifrenizi kontrol ediniz!', isSuccess: false);
      }
    } else {
      return StudentLoginResult(message: 'Bu numaraya kayıtlı öğrenci bulunamadı!', isSuccess: false);
    }
  }
}
