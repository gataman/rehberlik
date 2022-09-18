import 'package:firebase_auth/firebase_auth.dart';
import 'package:rehberlik/services/auth_service.dart';

import '../common/locator.dart';

class AuthRepository implements AuthService {
  final AuthService _service = locator<AuthService>();
  @override
  Future<UserCredential> login({required String email, required String password}) =>
      _service.login(email: email, password: password);
}
