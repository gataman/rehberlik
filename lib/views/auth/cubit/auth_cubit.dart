import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/repository/auth_repository.dart';

import '../../../common/locator.dart';

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

  Future<UserCredential> login({required String email, required String password}) {
    return _authRepository.login(email: email, password: password);
  }
}
