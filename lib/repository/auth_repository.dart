import '../common/models/student_login_result.dart';
import '../common/models/teacher_login_result.dart';
import '../services/auth_service.dart';

import '../common/locator.dart';

class AuthRepository implements AuthService {
  final AuthService _service = locator<AuthService>();

  @override
  Future<StudentLoginResult> studentLogin({required String number, required String password}) =>
      _service.studentLogin(number: number, password: password);

  @override
  Future<TeacherLoginResult> teacherLogin({required String email, required String password}) =>
      _service.teacherLogin(email: email, password: password);
}
