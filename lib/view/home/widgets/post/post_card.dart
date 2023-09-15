import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/view/home/widgets/post/profile_detile.dart';
import 'package:get/get.dart';

class PostCardTopPart extends StatelessWidget {
  PostCardTopPart(
      {super.key,
      required this.size,
      required this.image,
      required this.postId,
      required this.postUserId,
      required this.username,
      required this.profile});

  final Size size;
  String image;
  String username;
  String postId;
  String postUserId;
  String profile;
  final postCntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PostPofilePart(
          username: username,
          size: size,
          image: profile,
        ),
        IconButton(
            onPressed: () {
              postCntrl.savePost(postUserId, postId, image);
            },
            icon: Icon(Icons.save))
      ],
    );
  }
}
