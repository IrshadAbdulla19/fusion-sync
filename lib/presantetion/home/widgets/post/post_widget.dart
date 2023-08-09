import 'package:flutter/material.dart';
import 'package:fusion_sync/application/post_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/like_animation.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_bottom_part.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_card.dart';
import 'package:get/get.dart';

class PostWidget extends StatelessWidget {
  PostWidget({
    super.key,
    required this.size,
    required this.image,
    required this.description,
    required this.username,
    required this.profileUrl,
    required this.time,
    required this.likes,
    required this.postId,
    required this.postUserId,
  });

  final Size size;
  final postCntrl = Get.put(PostController());
  String time;
  List likes;
  String postId;
  String postUserId;
  String image;
  String profileUrl;
  String description;
  String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PostCardTopPart(
            username: username,
            size: size,
            image: profileUrl,
          ),
          GestureDetector(
            onDoubleTap: () async {
              postCntrl.likePost(postCntrl.auth.currentUser?.uid ?? 'userid',
                  postUserId, postId, likes);
              postCntrl.allUsresDetiles();
              postCntrl.isAnimating.value = true;
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    color: kBlackColor,
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
                  ),
                ),
                Obx(
                  () => AnimatedOpacity(
                    duration: const Duration(milliseconds: 50),
                    opacity: postCntrl.isAnimating.value ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: postCntrl.isAnimating.value,
                      onEnd: () {
                        postCntrl.isAnimating.value = false;
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            '$time ',
            style: normalTextStyleBlack,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$username ',
                style: miniTextHeads,
              ),
              Text(
                '   $description',
                style: miniText,
              ),
            ],
          ),
          PostWidgetBottomPart(
            postId: postId,
            postUserId: postUserId,
            likes: likes,
          )
        ],
      ),
    );
  }
}
