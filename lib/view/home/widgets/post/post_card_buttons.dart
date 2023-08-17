import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/home/widgets/post/comment.dart';
import 'package:get/get.dart';

class PostCardLikeBottomItems extends StatelessWidget {
  PostCardLikeBottomItems({
    super.key,
    required this.likes,
    required this.text,
    required this.postId,
    required this.postUserId,
  });
  final postCntrl = Get.put(PostController());
  List likes;
  String text;
  String postId;
  String postUserId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              postCntrl.likePost(postCntrl.auth.currentUser?.uid ?? 'userid',
                  postUserId, postId, likes);
              postCntrl.likeUserDetiles(postUserId, postId);
            },
            icon: likes.contains(postCntrl.auth.currentUser?.uid)
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border)),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}

class PostCardCommentBottomItems extends StatelessWidget {
  PostCardCommentBottomItems({
    super.key,
    required this.icon,
    required this.text,
    required this.postId,
    required this.postUserId,
  });
  IconData icon;
  String text;
  String postId;
  String postUserId;
  final postCntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () async {
              await postCntrl.postCommentDetiles(postUserId, postId);
              Get.to(CommentScreen(
                postId: postId,
                postUserId: postUserId,
              ));
            },
            icon: Icon(icon)),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}

class PostCardBottomItems extends StatelessWidget {
  PostCardBottomItems({super.key, required this.icon, required this.text});
  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(icon)),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}
