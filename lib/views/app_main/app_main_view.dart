import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/navigaton/app_router/app_router.dart';
import '../../common/navigaton/app_router/guards/admin_auth_guard.dart';
import '../../common/navigaton/app_router/guards/auth_guard.dart';
import '../../common/navigaton/app_router/guards/teacher_auth_guard.dart';
import '../../common/themes/custom_theme.dart';
import '../../core/init/locale_manager.dart';
import '../../core/init/pref_keys.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import '../../common/navigaton/app_router/guards/arguments_guard.dart';
import '../../common/navigaton/app_router/guards/student_auth_guard.dart';
import '../admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import 'cubit/app_main_cubit.dart';
import 'search/cubit/search_student_cubit.dart';

class AppMainView extends StatelessWidget {
  AppMainView({Key? key}) : super(key: key);
  final _appRouter = AppRouter(
      argumentsGuard: ArgumentsGuard(),
      teacherAuthGuard: TeacherAuthGuard(),
      studentAuthGuard: StudentAuthGuard(),
      adminAuthGuard: AdminAuthGuard(),
      authGuard: AuthGuard());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClassListCubit>(
          create: (_) => ClassListCubit()..fetchClassList(),
          lazy: false,
        ),
        BlocProvider<SearchStudentCubit>(
          create: (_) => SearchStudentCubit(),
          lazy: false,
        ),
        BlocProvider<AppMainCubit>(
          create: (_) => AppMainCubit(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<AppMainCubit, AppMainState>(
        builder: (context, state) {
          final themePref = SharedPrefs.instance.getInt(PrefKeys.theme.toString());
          ThemeType themeType = ThemeType.dark;
          if (themePref == 1) {
            themeType = ThemeType.light;
          }

          ThemeData theme = CustomTheme(theme: themeType).getAppTheme();

          return MaterialApp.router(
            /*
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('tr', ''),
                  ],
                  locale: const Locale('tr'),
          
                   */

            localizationsDelegates: [...context.localizationDelegates, SfGlobalLocalizations.delegate],
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            debugShowCheckedModeBanner: false,
            title: 'Yavuz Selim Ortaokulu Başarı İzleme Uygulaması',
            theme: theme,
            //initialRoute: AppPages.initial,
            //defaultTransition: Transition.fadeIn,
            // getPages: AppPages.adminPages,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            //onGenerateRoute: AppPages.onGenerateRoute,
          );
        },
      ),
    );
  }
}
