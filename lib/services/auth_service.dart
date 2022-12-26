import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rehberlik/common/models/teacher_login_result.dart';
import 'package:rehberlik/models/teacher.dart';

import '../common/models/student_login_result.dart';
import '../models/student.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<TeacherLoginResult> teacherLogin({required String email, required String password}) async {
    TeacherLoginResult loginResult = TeacherLoginResult(isSuccess: false, message: 'Bir hata oluştu');
    //UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        final teacherUID = credential.user!.uid;
        final colRef = _db.collection('teachers').doc(teacherUID).withConverter(
              fromFirestore: Teacher.fromFirestore,
              toFirestore: (Teacher object, _) => object.toFirestore(),
            );

        final teacherData = await colRef.get();
        final teacher = teacherData.data();

        if (teacher != null) {
          loginResult.teacher = teacher;
          loginResult.isSuccess = true;
          loginResult.message = 'Başarıyla giriş yapıldı. Yönlendiriliyorsunuz...';
        } else {
          loginResult.message = 'Giriş yapıldı ancak kullanıcı bilgisi alınamadı';
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loginResult.message = 'Bu email adresine kayıtlı kullanıcı bulunamadı';
      } else if (e.code == 'wrong-password') {
        loginResult.message = 'Lütfen şifrenizi kontrol edin!';
      } else {
        loginResult.message = ' Bir hata oluştu. Hata kodu: ${e.code}';
      }
    }
    return loginResult;
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
