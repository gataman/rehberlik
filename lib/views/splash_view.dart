import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkUser();
    return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Yükleniyor"),
        ));
  }

  void _checkUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        debugPrint(user.uid);
      } else {
        debugPrint("User null");
      }
    });
  }
}
