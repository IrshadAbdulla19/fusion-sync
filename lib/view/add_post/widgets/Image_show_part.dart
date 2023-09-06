import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/widgets/post_img_pick.dart';
import 'package:get/get.dart';

class ImageSelectionPart extends StatelessWidget {
  const ImageSelectionPart({
    super.key,
    required this.postCntrl,
    required this.size,
  });

  final PostController postCntrl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Obx(() => postCntrl.imgFile.value != ''
        ? Container(
            width: double.infinity,
            height: size.height * 0.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(postCntrl.imgFile.value)),
                    fit: BoxFit.cover)),
            child:
                postCntrl.load.value ? circularProgresKBlack : const SizedBox(),
          )
        : Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: size.height * 0.5,
            child: PostImagePickWidget(
              size: size,
            )));
  }
}
