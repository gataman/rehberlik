import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_strategy/url_strategy.dart';

import 'common/constants.dart';
import 'common/locator.dart';
import 'core/init/locale_manager.dart';
import 'core/init/pref_keys.dart';
import 'views/app_main/app_main_view.dart';

void main() async {
  await _init();

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
  await dotenv.load(); // .env documents loaded
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await EasyLocalization.ensureInitialized();
  await setupFirebaseOptions();
  await SharedPrefs.init();
  setupLocator();
  final schoolId = dotenv.env['SHOOL_ID']!;
  await SharedPrefs.instance.setString(PrefKeys.schoolID.toString(), schoolId);
}

Future<void> setupFirebaseOptions() async {
  final apiKey = dotenv.env['FIREBASE_API_KEY']!;
  final projectId = dotenv.env['FIREBASE_PROJECT_ID']!;
  final senderId = dotenv.env['FIREBASE_SENDER_ID']!;
  final appId = dotenv.env['FIREBASE_APP_ID']!;
  final measurementId = dotenv.env['FIREBASE_MEASUREMENT_ID']!;

  if (kIsWeb || Platform.isIOS) {
    await Firebase.initializeApp(
        //web options
        options: FirebaseOptions(
            apiKey: apiKey,
            authDomain: "$projectId.firebaseapp.com",
            projectId: projectId,
            storageBucket: "$projectId.appspot.com",
            messagingSenderId: senderId,
            appId: appId,
            measurementId: measurementId));
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
