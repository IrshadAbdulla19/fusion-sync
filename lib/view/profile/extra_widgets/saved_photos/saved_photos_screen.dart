import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class SavedPhotosScreen extends StatelessWidget {
  SavedPhotosScreen({super.key});
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Photos",
          style: normalTextStyleWhite,
        ),
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
        () => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemCount: postCntrl.savePostList.length,
          itemBuilder: (context, index) {
            var image = '';
            var postId = '';
            try {
              var savePost = postCntrl.savePostList[index];
              image = savePost['photoUrl'];
              postId = savePost['postId'];
            } catch (e) {}
            return InkWell(
              onTap: () =>
                  Get.to(() => SavedPostView(image: image, postId: postId)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            image == '' ? nonUserNonProfile : image),
                        fit: BoxFit.cover)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SavedPostView extends StatelessWidget {
  SavedPostView({required this.image, super.key, required this.postId});
  String image;
  String postId;
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
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
                          await postCntrl.deletSavePost(postId);
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
        body: PhotoView(imageProvider: NetworkImage(image)));
  }
}
