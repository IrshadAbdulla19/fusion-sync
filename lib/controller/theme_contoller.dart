import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var theme = false.obs;

  ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
  );
  ThemeData darkTheme = ThemeData.dark();

  bool isDarkMode = false;

  ThemeData themeData = ThemeData(
      primaryColor: Colors.black,
      primarySwatch: primaryBlack,
      fontFamily: "Changa");
  void toggleTheme() async {
    if (theme.value == false) {
      themeData = darkTheme;
    }

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('isDarkMode', isDarkMode);
  }
}
