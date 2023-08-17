import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:get/get.dart';

ValueNotifier<int> pageChangeNotifier = ValueNotifier(0);

class BottomNavigatonWidget extends StatelessWidget {
  BottomNavigatonWidget({super.key});
  final navCntrlr = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        onTap: (value) {
          navCntrlr.index.value = value;
        },
        currentIndex: navCntrlr.index.value,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
