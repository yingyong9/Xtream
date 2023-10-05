import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:upgrader/upgrader.dart';
import 'package:xstream/pages/homePage.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_service.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        AppService().findCurrentUserModel().then((value) {
          runApp(MyApp());
        });
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeHappy',
      theme: ThemeData(
        brightness: Brightness.dark,
        hintColor: Colors.white,
        // accentColor: Colors.white,
        primaryColor: ColorPlate.orange,
        // primaryColorBrightness: Brightness.dark,
        scaffoldBackgroundColor: ColorPlate.back1,
        dialogBackgroundColor: ColorPlate.back2,
        // accentColorBrightness: Brightness.light,
        textTheme: const TextTheme(
          bodyText1: StandardTextStyle.normal,
        ),
      ),
      home: UpgradeAlert(
        child: const HomePage(),
      ),
      // home: CameraPage(),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
