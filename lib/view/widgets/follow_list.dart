import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class FollowListWidget extends StatelessWidget {
  FollowListWidget({super.key, required this.head, required this.followList});
  final postCntrl = Get.put(PostController());
  final profileCntrl = Get.put(ProfileController());
  String head;
  List followList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          head,
          style: normalTextStyleBlack,
        ),
      ),
      body: ListView.builder(
        itemCount: followList.length,
        itemBuilder: (context, index) {
          var profile = '';
          var username = '';
          var uid = '';
          try {
            var user = followList[index];

            for (var element in postCntrl.allUserDetiles) {
              if (element['uid'] == user) {
                profile = element['profilePic'];
                username = element['username'];
                uid = element['uid'];
              }
            }
          } catch (e) {
            print(
                "the erorr catch by the follow list is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$e");
          }
          return GestureDetector(
            onTap: () {
              profileCntrl.otherUserDetiles(uid);
            },
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(profile == '' ? nonUserNonProfile : profile),
                ),
                title: Text(
                  username,
                  style: normalTextStyleBlack,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
