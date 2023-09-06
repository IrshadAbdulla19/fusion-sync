import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';

class AddPostAppBAr extends StatelessWidget {
  const AddPostAppBAr({
    super.key,
    required this.postCntrl,
    required this.size,
  });

  final PostController postCntrl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              postCntrl.imgFile.value = '';
              postCntrl.photoUrl = '';
              postCntrl.dicriptionCntrl.clear();
            },
            color: kBlackColor,
            iconSize: size.height * 0.05,
            icon: const Icon(Icons.close)),
        Text(
          "New Post",
          style: mainTextHeads,
        ),
      ],
    );
  }
}
