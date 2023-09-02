import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class LikedUsers extends StatelessWidget {
  LikedUsers({super.key, required this.likes});
  final postCntrl = Get.put(PostController());
  List likes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: likes.length,
        itemBuilder: (context, index) {
          var userId = likes[index];
          var username = '';
          var profile = '';
          for (var element in postCntrl.allUserDetiles) {
            if (userId == element['uid']) {
              username = element['username'];
              profile = element['profilePic'];
            }
          }
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(profile == '' ? nonUserNonProfile : profile),
              ),
              title: Text(username),
            ),
          );
        },
      ),
    );
  }
}
