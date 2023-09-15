import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/message_notification_service.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:fusion_sync/controller/notification_controller.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/controller/storie_controller.dart';
import 'package:fusion_sync/view/add_post/add_post_screen.dart';
import 'package:fusion_sync/view/home/home_screen.dart';
import 'package:fusion_sync/view/main/widgets/bottom_nav_widget.dart';
import 'package:fusion_sync/view/notification/notification_screen.dart';
import 'package:fusion_sync/view/profile/user_profile_screen.dart';
import 'package:fusion_sync/view/search/search_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final postCntrl = Get.put(PostController());
  final stryCntl = Get.put(StorieController());
  final profileCntrl = Get.put(ProfileController());
  final navCntrl = Get.put(NavController());
  final notiCntl = Get.put(NotificationController());
  var pages = [
    HomeScreen(),
    SearchScreen(),
    AddPostScreen(),
    NotificationScreen(),
    UserProfile()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.display(message);
    });
    LocalNotificationService.storeToken();
  }

  @override
  Widget build(BuildContext context) {
    postCntrl.allUsersGet();
    profileCntrl.userDetiles();
    postCntrl.thisUserDetiles();
    stryCntl.getAllStorieOfuser();
    stryCntl.getthisUserDetiles();
    stryCntl.autodeletStory();
    notiCntl.getNotificationList();
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: pages[navCntrl.index.value],
        ),
      ),
      bottomNavigationBar: BottomNavigatonWidget(),
    );
  }
}
