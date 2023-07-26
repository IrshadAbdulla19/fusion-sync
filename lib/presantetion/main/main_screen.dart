import 'package:flutter/material.dart';
import 'package:fusion_sync/presantetion/add_post/add_post_screen.dart';
import 'package:fusion_sync/presantetion/home/home_screen.dart';
import 'package:fusion_sync/presantetion/main/widgets/bottom_nav_widget.dart';
import 'package:fusion_sync/presantetion/notification/notification_screen.dart';
import 'package:fusion_sync/presantetion/profile/user_profile_screen.dart';
import 'package:fusion_sync/presantetion/search/search_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  var pages = [
    HomeScreen(),
    SearchScreen(),
    AddPostScreen(),
    NotificationScreen(),
    UserProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: pageChangeNotifier,
            builder: (cntx, int currentPage, child) {
              return pages[currentPage];
            }),
      ),
      bottomNavigationBar: BottomNavigatonWidget(),
    );
  }
}
