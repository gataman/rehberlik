import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehberlik/core/init/pref_keys.dart';
import 'package:rehberlik/views/app_main/app_main_view.dart';
import 'common/constants.dart';
import 'common/locator.dart';
import 'core/init/locale_manager.dart';

void main() async {
  await _init();

  //final ClassesRepository _repository = locator<ClassesRepository>();
  //final SchoolRepository _repositorySchool = locator<SchoolRepository>();
  //final LessonRepository _repositoryLesson = locator<LessonRepository>();

  //var filters = {"classLevel": 5, "className": "5-B"};

  await SharedPrefs.instance.setString(PrefKeys.schoolID.toString(), 'w7WZvgcVPKVheXnhxMHE');

  runApp(
    EasyLocalization(
      path: LANG_PATH,
      supportedLocales: const [TR_LOCALE],
      fallbackLocale: TR_LOCALE,
      child: AppMainView(),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupFirebaseOptions();
  await SharedPrefs.init();
  setupLocator();
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
