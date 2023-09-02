import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationService {
  static String serverKey =
      "AAAAtPztbSg:APA91bEVoOSJZ6C-ykJoSx63aJ9Z5zNcBPsUkhEvARINCyq6AbdNhnixSaRsIbltG5wH3lI3uUKHwVmSKs8Ad2bte7c9Vl4tvbTwW7PgGd9jBYMfyawmT5X4lWK61Xrn3n3VLLj2ooVC";

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      print("In notification method");
      Random random = new Random();
      int id = random.nextInt(1000);
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("mychanel", "my chanel",
              importance: Importance.max, priority: Priority.high));

      print("my id is ${id.toString()}");
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      print("erorr>>>>>>>>$e");
    }
  }

  static Future<void> sendNotification(
      {String? title, String? message, String? token}) async {
    print("\n\n\n\n\n\n\n\n");
    print("token is $token");
    print("\n\n\n\n\n\n\n\n");

    final data = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "satatus": "done",
      "message": message
    };
    try {
      http.Response r = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': message, 'title': title},
            'priority': 'high',
            'data': data,
            "to": "$token"
          },
        ),
      );
      print(r.body);
      if (r.statusCode == 200) {
        print("done");
      } else {
        print("\n\n\n\n\n\n\n\n");
        print("the erorr is this ${r.statusCode}");
        print("\n\n\n\n\n\n\n\n");
      }
    } catch (e) {
      print("Exception $e");
    }
  }

  static storeToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"fcmToken": token!}, SetOptions(merge: true));
    } catch (e) {
      print("erorr is $e");
    }
  }
}
