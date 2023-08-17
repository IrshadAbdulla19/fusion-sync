import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/view/add_post/add_post_screen.dart';
import 'package:fusion_sync/view/home/home_screen.dart';
import 'package:fusion_sync/view/main/widgets/bottom_nav_widget.dart';
import 'package:fusion_sync/view/notification/notification_screen.dart';
import 'package:fusion_sync/view/profile/user_profile_screen.dart';
import 'package:fusion_sync/view/search/search_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final postCntrl = Get.put(PostController());
  final profileCntrl = Get.put(ProfileController());
  final navCntrl = Get.put(NavController());
  var pages = [
    HomeScreen(),
    SearchScreen(),
    AddPostScreen(),
    NotificationScreen(),
    UserProfile()
  ];
  @override
  Widget build(BuildContext context) {
    postCntrl.allUsersGet();
    profileCntrl.userDetiles();
    postCntrl.thisUserDetiles();
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
