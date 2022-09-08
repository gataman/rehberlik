import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/navigaton/guards/student_detail_guard.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import '../../../common/navigaton/app_router.dart';

class AdminMainView extends StatelessWidget {
  AdminMainView({Key? key}) : super(key: key);
  final _appRouter = AppRouter(argumentsGuard: ArgumentsGuard());

  @override
  Widget build(BuildContext context) {
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
      title: 'Rehberlik - Yönetici Paneli',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBackColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
        canvasColor: darkSecondaryColor,
      ),
      //initialRoute: AppPages.initial,
      //defaultTransition: Transition.fadeIn,
      // getPages: AppPages.adminPages,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      //onGenerateRoute: AppPages.onGenerateRoute,
    );
  }
}
