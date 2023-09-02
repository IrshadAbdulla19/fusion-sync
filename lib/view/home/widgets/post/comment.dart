import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key, required this.postId, required this.postUserId});
  String postId;
  String postUserId;
  final postCntrl = Get.put(PostController());
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kBlackColor,
            )),
        title: const Text(
          "Comments",
          style: normalTextStyleBlack,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: postCntrl.allCommentList.length,
                itemBuilder: (context, index) {
                  var username = '';
                  var profilePic = '';
                  var userId = '';
                  var user = postCntrl.allCommentList[index];
                  var time =
                      postCntrl.dateTimeFormatChange(user['time'].toDate());
                  var comment = user['comment'];
                  var commentId = user['commentId'];
                  for (var element in postCntrl.allUserDetiles) {
                    if (user['commentedUSerId'] == element['uid']) {
                      username = element['username'];
                      profilePic = element['profilePic'];
                      userId = element['uid'];
                    }
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profilePic),
                    ),
                    title: Text(
                      username,
                      style: normalTextStyleGrey,
                    ),
                    subtitle: Text(
                      comment,
                      style: normalTextStyleBlackHead,
                    ),
                    trailing: Wrap(
                      children: [
                        Column(
                          children: [
                            Text(
                              time,
                              style: normalTextStyleBlack,
                            ),
                            userId == postCntrl.auth.currentUser!.uid
                                ? IconButton(
                                    onPressed: () {
                                      postCntrl.deletePostComment(
                                          postId, commentId);
                                      postCntrl.postCommentDetiles(
                                          postUserId, postId);
                                    },
                                    color: kBlackColor,
                                    icon: Icon(Icons.delete))
                                : SizedBox()
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileCntrl.profile.value == ''
                      ? nonUserNonProfile
                      : profileCntrl.profile.value),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: postCntrl.commentCntrl,
                      decoration: InputDecoration(
                          hintText: 'Comment as ${profileCntrl.username}',
                          border: InputBorder.none,
                          suffixIcon: TextButton(
                              onPressed: () {
                                postCntrl.postComments(postId, postUserId,
                                    postCntrl.auth.currentUser?.uid);
                                // profileCntrl.userDetiles();
                                postCntrl.postCommentDetiles(
                                    postUserId, postId);
                              },
                              child: const Text(
                                'Post',
                                style: normalTextStyleBlack,
                              ))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
