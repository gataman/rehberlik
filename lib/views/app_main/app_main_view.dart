import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/navigaton/app_router/app_router.dart';
import 'package:rehberlik/common/navigaton/app_router/guards/teacher_auth_guard.dart';
import 'package:rehberlik/common/themes/custom_theme.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import '../../common/navigaton/app_router/guards/arguments_guard.dart';
import '../../common/navigaton/app_router/guards/student_auth_guard.dart';
import '../admin/admin_classes/components/class_list_card/cubit/class_list_cubit.dart';
import '../admin/admin_dashboard/components/agenda_box/cubit/agenda_box_cubit.dart';
import '../admin/admin_lessons/components/lesson_list_card/cubit/lesson_list_cubit.dart';
import '../admin/admin_students/components/student_list_card/cubit/student_list_cubit.dart';
import 'cubit/app_main_cubit.dart';
import 'search/cubit/search_student_cubit.dart';

class AppMainView extends StatelessWidget {
  AppMainView({Key? key}) : super(key: key);
  final _appRouter = AppRouter(
    argumentsGuard: ArgumentsGuard(),
    teacherAuthGuard: TeacherAuthGuard(),
    studentAuthGuard: StudentAuthGuard(),
  );

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
          final ThemeData theme = CustomTheme(theme: state.themeType).getAppTheme();
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
            title: 'Rehberlik',
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

  ThemeData _setTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.amber,
      //highlightColor: Colors.amber,
      scaffoldBackgroundColor: darkBackColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme.apply(bodyColor: Colors.white),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      canvasColor: darkSecondaryColor,
    );
  }
}
