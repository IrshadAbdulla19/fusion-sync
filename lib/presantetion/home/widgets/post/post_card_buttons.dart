import 'package:flutter/material.dart';
import 'package:fusion_sync/application/post_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
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
              postCntrl.allUsresDetiles();
            },
            icon: likes.contains(postCntrl.auth.currentUser?.uid)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
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
