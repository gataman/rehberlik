import 'package:firebase_auth/firebase_auth.dart';
import 'package:rehberlik/common/models/student_login_result.dart';
import 'package:rehberlik/models/student.dart';
import 'package:rehberlik/services/auth_service.dart';

import '../common/locator.dart';

class AuthRepository implements AuthService {
  final AuthService _service = locator<AuthService>();
  @override
  Future<UserCredential> teacherLogin({required String email, required String password}) =>
      _service.teacherLogin(email: email, password: password);

  @override
  Future<StudentLoginResult> studentLogin({required String number, required String password}) =>
      _service.studentLogin(number: number, password: password);
}
