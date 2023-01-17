import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehberlik/common/themes/custom_theme.dart';
import 'package:rehberlik/core/init/locale_manager.dart';
import 'package:rehberlik/core/init/pref_keys.dart';

part 'app_main_state.dart';

class AppMainCubit extends Cubit<AppMainState> {
  AppMainCubit() : super(AppMainState(themeType: ThemeType.dark));

  bool isDark = true;

  void changeTheme() {
    if (isDark) {
      isDark = false;
      SharedPrefs.instance.setInt(PrefKeys.theme.toString(), 1);
      emit(AppMainState(themeType: ThemeType.light));
    } else {
      SharedPrefs.instance.setInt(PrefKeys.theme.toString(), 0);
      isDark = true;
      emit(AppMainState(themeType: ThemeType.dark));
    }
  }
}
