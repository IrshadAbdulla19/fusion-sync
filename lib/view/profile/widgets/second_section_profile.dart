import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/profile/widgets/counts_in_profil.dart';
import 'package:fusion_sync/view/widgets/follow_list.dart';
import 'package:fusion_sync/view/widgets/other_user_profile/other_user_profile.dart';
import 'package:get/get.dart';

class SecondSection extends StatelessWidget {
  SecondSection({
    super.key,
  });
  final proCntrl = Get.put(ProfileController());
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => CountsInProfile(
            num: postCntrl.thisUserPost.length.toString(),
            text: "Posts",
          ),
        ),
        StreamBuilder(
            stream: proCntrl.getInstance
                .doc(proCntrl.auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? InkWell(
                      onTap: () => Get.to(() => FollowListWidget(
                            followList: snapshot.data['Followers'],
                            head: 'Followers',
                          )),
                      child: CountsInProfile(
                        num: snapshot.data['Followers'].length.toString(),
                        text: "Followers",
                      ),
                    )
                  : circularProgresKBlack;
            }),
        StreamBuilder(
            stream: proCntrl.getInstance
                .doc(proCntrl.auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? InkWell(
                      onTap: () => Get.to(
                        () => FollowListWidget(
                            head: "Following",
                            followList: snapshot.data['Following']),
                      ),
                      child: CountsInProfile(
                        num: snapshot.data['Following'].length.toString(),
                        text: "Following",
                      ),
                    )
                  : circularProgresKBlack;
            }),
      ],
    );
  }
}
