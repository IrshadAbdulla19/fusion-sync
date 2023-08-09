import 'package:flutter/material.dart';
import 'package:fusion_sync/application/post_controller.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/like_animation.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_card_buttons.dart';
import 'package:get/get.dart';

class PostWidgetBottomPart extends StatelessWidget {
  PostWidgetBottomPart({
    super.key,
    required this.likes,
    required this.postId,
    required this.postUserId,
  });
  String postId;
  String postUserId;
  List likes;
  final postCntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LikeAnimation(
          isAnimating: likes.contains(postCntrl.auth.currentUser?.uid),
          smallLike: true,
          child: PostCardLikeBottomItems(
            postId: postId,
            postUserId: postUserId,
            likes: likes,
            text: "${likes.length} Likes",
          ),
        ),
        PostCardBottomItems(
          icon: Icons.comment,
          text: "16 comments",
        ),
        PostCardBottomItems(
          icon: Icons.send,
          text: "Share",
        ),
      ],
    );
  }
}
