import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/view/add_post/widgets/Image_show_part.dart';
import 'package:fusion_sync/view/add_post/widgets/app_bar.dart';
import 'package:fusion_sync/view/widgets/for_textfileds.dart';
import 'package:get/get.dart';

import 'widgets/post_button.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final postCntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.08),
          child: AddPostAppBAr(postCntrl: postCntrl, size: size),
        ),
        body: ListView(
          children: [
            ImageSelectionPart(postCntrl: postCntrl, size: size),
            ForTextFormFileds(
                text: '',
                hintText: 'Add caption',
                labelText: 'Caption',
                cntrl: postCntrl.dicriptionCntrl),
            PostButtonWidget(size: size, postCntrl: postCntrl)
          ],
        ));
  }
}
