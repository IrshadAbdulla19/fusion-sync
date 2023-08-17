import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/add_post/add_post_screen.dart';
import 'package:get/get.dart';

class PostsTopPart extends StatelessWidget {
  const PostsTopPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Get.to(AddPostScreen());
              },
              iconSize: 30,
              icon: const Icon(
                Icons.image_outlined,
              )),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Posts",
            style: normalTextStyleBlack.copyWith(fontSize: 20),
          )
        ],
      ),
    );
  }
}
