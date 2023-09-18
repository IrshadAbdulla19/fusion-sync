import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/auth_controller.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/profile/extra_widgets/saved_photos/saved_photos_screen.dart';
import 'package:fusion_sync/view/profile/extra_widgets/settings/settings_screen.dart';
import 'package:fusion_sync/view/profile/extra_widgets/terms_and_privacy/terms_and_privacy.dart';
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
                    : CircularProgressIndicator(
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
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          MenuSettingItems(size, Icons.account_circle, "About", context),
          MenuSettingItems(
              size, Icons.privacy_tip_sharp, "Privacy and Policy", context),
          MenuSettingItems(
              size, Icons.file_copy_outlined, "Terms and Condition", context),
          MenuSettingItems(size, Icons.save, "Saved", context),
          MenuSettingItems(size, Icons.logout_outlined, "LogOut", context),
        ],
      ),
    );
  }

  Row MenuSettingItems(
      Size size, IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              if (text == "About") {
                showAboutDialog(
                    context: context,
                    applicationName: "Fusion sync",
                    applicationIcon: Image.asset(
                      "asset/images/Fusion Sync App Logo.png",
                      height: 32,
                      width: 32,
                    ),
                    applicationVersion: "1.0.1",
                    children: [
                      const Text(
                          "Fusion sync is a social media application where users can post their thoughts, images. Users can interact with other users through chat and calls also react to other users post through likes, comments and share."),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("App developed by Irshad A A.")
                    ]);
              } else if (text == "Privacy and Policy") {
                showDialog(
                  context: context,
                  builder: (context) => privacydialoge(
                    mdFileName: 'privacy_policy.md',
                  ),
                );
              } else if (text == "Terms and Condition") {
                showDialog(
                  context: context,
                  builder: (context) => privacydialoge(
                    mdFileName: 'terms_and_contitions.md',
                  ),
                );
              } else if (text == "Saved") {
                postCntrl.getSaveList();
                Get.to(() => SavedPhotosScreen());
              } else if (text == "LogOut") {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "LogOut",
                        style: normalTextStyleBlack,
                      ),
                      content: Text(
                        "Are sure to Logout",
                        style: normalTextStyleBlack,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            cntrl.signOut();
                          },
                          child: Text(
                            "Yes",
                            style: normalTextStyleBlack,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "No",
                            style: normalTextStyleBlack,
                          ),
                        )
                      ],
                    );
                  },
                );
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
