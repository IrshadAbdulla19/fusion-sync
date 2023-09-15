import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class SavedPhotosScreen extends StatelessWidget {
  SavedPhotosScreen({super.key});
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemCount: postCntrl.savePostList.length,
          itemBuilder: (context, index) {
            var image = '';
            try {
              var savePost = postCntrl.savePostList[index];
              image = savePost['photoUrl'];
            } catch (e) {}
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          NetworkImage(image == '' ? nonUserNonProfile : image),
                      fit: BoxFit.cover)),
            );
          },
        ),
      ),
    );
  }
}
