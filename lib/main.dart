import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehberlik/common/constants.dart';
import 'package:rehberlik/common/locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rehberlik/views/admin/admin_classes/admin_classes_controller.dart';
import 'package:rehberlik/views/admin/admin_view.dart';
import 'package:rehberlik/views/admin/admin_view_binding.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebaseOptions();
  setupLocator();

  //final ClassesRepository _repository = locator<ClassesRepository>();
  //final SchoolRepository _repositorySchool = locator<SchoolRepository>();
  //final LessonRepository _repositoryLesson = locator<LessonRepository>();

  //var filters = {"classLevel": 5, "className": "5-B"};
  await GetStorage.init();

  final box = GetStorage();
  box.write("schoolID", "w7WZvgcVPKVheXnhxMHE");

  final _controller = Get.put(AdminClassesController());
  if (_controller.studentWithClassList.value == null) {
    _controller.getAllStudentWithClass();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //GetStorage getStorage = GetStorage();
    //final homeVM = Provider.of<HomeViewModel>(context);

    return GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr', ''),
        ],
        locale: const Locale('tr'),
        debugShowCheckedModeBanner: false,
        title: 'Rehberlik - Yönetici Paneli',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          ),
          canvasColor: secondaryColor,
        ),
        initialRoute: "/admin",
        defaultTransition: Transition.fadeIn,
        getPages: [
          GetPage(
              name: "/admin",
              page: () => AdminView(),
              binding: AdminViewBinding()),
        ]);
  }
}

Future<void> setupFirebaseOptions() async {
  if (kIsWeb || Platform.isIOS) {
    await Firebase.initializeApp(
        //web options
        options: const FirebaseOptions(
            apiKey: "AIzaSyBXzMyeobl0HH0qD36Kk6JgoY162U8LJlo",
            authDomain: "rehberlik-810e1.firebaseapp.com",
            projectId: "rehberlik-810e1",
            storageBucket: "rehberlik-810e1.appspot.com",
            messagingSenderId: "628522179079",
            appId: "1:628522179079:web:f24b8e41f3d064c91868a2"));
  } else {
    await Firebase.initializeApp();
  }

  /*
  final emulatorHost =
  (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
      ? '10.0.2.2'
      : 'localhost';

  await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  */
}
