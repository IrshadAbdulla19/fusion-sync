import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class PostButtonWidget extends StatelessWidget {
  const PostButtonWidget({
    super.key,
    required this.size,
    required this.postCntrl,
  });

  final Size size;
  final PostController postCntrl;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width * 0.05,
          decoration: BoxDecoration(
              color: kBlackColor, borderRadius: BorderRadius.circular(10)),
          child: postCntrl.loadPost.value
              ? Center(child: circularProgresKWhite)
              : TextButton(
                  onPressed: () {
                    postCntrl.addPost();
                  },
                  child: Text(
                    'Post',
                    style: normalTextStyleWhite,
                  )),
        ),
      ),
    );
  }
}
