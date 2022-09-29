import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/themes/custom_theme.dart';

part 'app_main_state.dart';

class AppMainCubit extends Cubit<AppMainState> {
  AppMainCubit() : super(AppMainState(themeType: ThemeType.dark));

  bool isDark = true;

  void changeTheme() {
    if (isDark) {
      isDark = false;
      emit(AppMainState(themeType: ThemeType.light));
    } else {
      isDark = true;
      emit(AppMainState(themeType: ThemeType.dark));
    }
  }
}
