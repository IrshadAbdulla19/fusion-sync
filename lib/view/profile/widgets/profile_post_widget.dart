import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ProfilePosts extends StatelessWidget {
  ProfilePosts({
    super.key,
  });

  final postcntrl = Get.put(PostController());

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
            var postId = userPostData['postId'];

            return GestureDetector(
              onTap: () {
                print("its working");
                Get.to(ProfilePostView(
                  description: description,
                  image: image,
                  postId: postId,
                ));
              },
              child: ProfilePostWidget(
                image: image,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfilePostView extends StatelessWidget {
  ProfilePostView(
      {required this.image,
      super.key,
      required this.description,
      required this.postId});
  String image;
  String description;
  String postId;
  final postCntrl = Get.put(PostController());
  var isExpanded = false.obs;

  void _toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                      child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await postCntrl.deletePost(postId);
                          Get.back();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                        color: kBlackColor,
                      ),
                      Text(
                        "Delete",
                        style: normalTextStyleBlack,
                      )
                    ],
                  ))
                ];
              },
            )
          ],
        ),
        body: Stack(
          children: [
            PhotoView(imageProvider: NetworkImage(image)),
            Align(
              alignment: Alignment.bottomLeft,
              child: Obx(
                () => GestureDetector(
                  onTap: _toggleExpansion,
                  child: AnimatedContainer(
                    color: Colors.black.withOpacity(0.5),
                    duration: Duration(milliseconds: 300),
                    width: double.infinity,
                    height: isExpanded.value ? size.height * 0.5 : 100.0,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView(children: [
                        Text(
                          description,
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class ProfilePostWidget extends StatelessWidget {
  ProfilePostWidget({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
            color: kBlackColor),
      ),
    );
  }
}
