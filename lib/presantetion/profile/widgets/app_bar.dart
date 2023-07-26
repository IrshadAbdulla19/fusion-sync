import 'package:flutter/material.dart';
import 'package:fusion_sync/application/auth_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:get/get.dart';

class ProfileAppBar extends StatelessWidget {
  ProfileAppBar({super.key, required this.size, required this.contxt});
  Size size;
  BuildContext contxt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "irshad_abdulla",
            style: blodText500,
          ),
        ),
        IconButton(
            onPressed: () {
              bottomSheet();
            },
            iconSize: size.width * 0.09,
            icon: Icon(Icons.menu_rounded))
      ],
    );
  }

  Future bottomSheet() {
    return showModalBottomSheet(
      context: contxt,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: size.height * 0.3,
          decoration: BoxDecoration(
              color: kWhiteColor, borderRadius: BorderRadius.circular(50)),
          child: BottomSheetMenu(),
        );
      },
    );
  }
}

class BottomSheetMenu extends StatelessWidget {
  BottomSheetMenu({super.key});
  final cntrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20),
      child: Column(
        children: [
          MenuSettingItems(size, Icons.settings, "Settings"),
          MenuSettingItems(size, Icons.verified, "Verify Account"),
          MenuSettingItems(size, Icons.save, "Saved"),
          MenuSettingItems(size, Icons.logout_outlined, "LogOut"),
        ],
      ),
    );
  }

  Row MenuSettingItems(Size size, IconData icon, String text) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              if (text == "Settings") {
              } else if (text == "Verify Account") {
              } else if (text == "Saved") {
              } else if (text == "LogOut") {
                cntrl.signOut();
              }
            },
            iconSize: size.width * 0.1,
            icon: Icon(icon)),
        Text(
          text,
          style: mainTextHeads,
        )
      ],
    );
  }
}
