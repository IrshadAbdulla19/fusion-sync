import 'package:flutter/material.dart';

ValueNotifier<int> pageChangeNotifier = ValueNotifier(0);

class BottomNavigatonWidget extends StatelessWidget {
  const BottomNavigatonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageChangeNotifier,
        builder: (cntx, int currentPage, child) {
          return BottomNavigationBar(
            onTap: (value) {
              pageChangeNotifier.value = value;
            },
            currentIndex: currentPage,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none_rounded),
                  label: 'Notifications'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded), label: 'Profile'),
            ],
          );
        });
  }
}
