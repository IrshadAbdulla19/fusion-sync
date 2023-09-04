import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/theme_contoller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final themeCntrl = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Theme"),
            trailing: _toggleSwitch(),
          );
        },
      ),
    );
  }

  Widget _toggleSwitch() {
    return ToggleSwitch(
      minWidth: 90.0,
      cornerRadius: 20.0,
      activeBgColors: const [
        [Colors.black],
        [Colors.white]
      ],
      activeFgColor: kBlackColor,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: kBlackColor,
      initialLabelIndex: 1,
      totalSwitches: 2,
      labels: ['Dark', 'Light'],
      radiusStyle: true,
      onToggle: (index) {
        if (index == 0) {
          themeCntrl.theme.value = false;
        } else {
          themeCntrl.theme.value = true;
        }
      },
    );
  }
}
