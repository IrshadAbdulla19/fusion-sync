import 'package:flutter/material.dart';
import 'package:fusion_sync/application/post_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:get/get.dart';

class ProfilePosts extends StatelessWidget {
  ProfilePosts({
    super.key,
  });

  final postcntrl = Get.put(PostController());
  var images = [
    "asset/images/post 6.jpeg",
    "asset/images/post 5.jpeg",
    "asset/images/post 7.jpg",
    "asset/images/post 8.webp"
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Obx(
        () => GridView.builder(
          itemCount: postcntrl.thisUserPost.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemBuilder: (context, index) {
            var userPostData = postcntrl.thisUserPost[index];
            var image = userPostData['photoUrl'];
            var description = userPostData['decription'];

            return ProfilePostWidget(
              image: image,
            );
          },
        ),
      ),
    );
  }
}

class ProfilePostWidget extends StatelessWidget {
  ProfilePostWidget({
    required this.image,
    super.key,
  });
  String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          color: kBlackColor),
    );
  }
}
