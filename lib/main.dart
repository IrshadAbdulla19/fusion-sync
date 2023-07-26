import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/splash/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: primaryBlack,
          fontFamily: "Handlee"),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  static const Color black = Color(0xFF000000);
}
