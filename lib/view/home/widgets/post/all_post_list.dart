import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/home/widgets/post/post_widget.dart';
import 'package:get/get.dart';

class ListOfPosts extends StatelessWidget {
  ListOfPosts({
    super.key,
    required this.size,
  });
  final postCntrl = Get.put(PostController());
  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Obx(
                () => ListView.builder(
                  itemCount: postCntrl.allPost.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var username = '';
                    var profileUrl = '';
                    List likes = [];
                    var image = '';
                    var postId = '';
                    var postUserId = '';
                    var time = '';
                    var description = '';
                    try {
                      var userPostData = postCntrl.allPost[index];
                      image = userPostData['photoUrl'];
                      likes = userPostData['like'];
                      postId = userPostData['postId'];
                      postUserId = userPostData['uid'];
                      time = postCntrl
                          .dateTimeFormatChange(userPostData['time'].toDate());
                      description = userPostData['decription'];
                      for (var element in snapshot.data.docs) {
                        if (element['uid'] == userPostData['uid']) {
                          username = element['username'];
                          profileUrl = element['profilePic'];
                          break;
                        }
                      }
                    } catch (e) {
                      print(
                          "the erorr in the post list is >>>>>>>>>>>>>>>>>>>>>>>>>>>>$e");
                    }
                    return PostWidget(
                      likes: likes,
                      size: size,
                      image: image,
                      time: time,
                      postId: postId,
                      postUserId: postUserId,
                      description: description,
                      username: username,
                      profileUrl: profileUrl,
                    );
                  },
                ),
              )
            : SizedBox(
                width: size.width * 0.5,
                height: size.height * 0.5,
                child: Center(
                  child: circularProgresKBlack,
                ),
              );
      },
    );
  }
}
