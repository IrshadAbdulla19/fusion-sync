import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/message_notification_service.dart';
import 'package:fusion_sync/controller/theme_contoller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/splash/splash_screen.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackGroudHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroudHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeCntrl = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeCntrl.themeData,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
