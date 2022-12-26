import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/models/teacher_login_result.dart';
import 'package:rehberlik/repository/auth_repository.dart';

import '../../../common/locator.dart';
import '../../../common/models/student_login_result.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(activeIndex: 0));
  final _authRepository = locator<AuthRepository>();

  int activeIndex = 0;

  void changeActiveIndex({required int index}) {
    if (activeIndex != index) {
      activeIndex = index;
      emit(AuthState(activeIndex: activeIndex));
    }
  }

  Future<TeacherLoginResult> teacherLogin({required String email, required String password}) {
    return _authRepository.teacherLogin(email: email, password: password);
  }

  Future<StudentLoginResult> studentLogin({required String number, required String password}) =>
      _authRepository.studentLogin(number: number, password: password);
}
