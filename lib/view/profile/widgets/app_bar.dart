import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/auth_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class ProfileAppBar extends StatelessWidget {
  ProfileAppBar({super.key, required this.size, required this.contxt});
  Size size;
  BuildContext contxt;
  final procntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<Object>(
              stream: procntrl.getInstance
                  .doc(procntrl.auth.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data['username'] ?? '',
                        style: blodText500,
                      )
                    : const CircularProgressIndicator(
                        color: kBlackColor,
                      );
              }),
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
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(50)),
              child: BottomSheetMenu(),
            ),
          ],
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
