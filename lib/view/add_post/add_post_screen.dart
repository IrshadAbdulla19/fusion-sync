import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/widgets/for_textfileds.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  final postCntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                postCntrl.imgFile.value = '';
                postCntrl.photoUrl = '';
                postCntrl.dicriptionCntrl.clear();
              },
              color: kBlackColor,
              iconSize: size.height * 0.05,
              icon: const Icon(Icons.close)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "New Post",
            style: mainTextHeads,
          ),
        ),
        body: ListView(
          children: [
            Obx(() => postCntrl.imgFile.value != ''
                ? Container(
                    width: double.infinity,
                    height: size.height * 0.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(postCntrl.imgFile.value)),
                            fit: BoxFit.cover)),
                    child: postCntrl.load.value
                        ? circularProgresKBlack
                        : const SizedBox(),
                  )
                : Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.height * 0.5,
                    child: PostImagePickWidget(
                      size: size,
                    ))),
            ForTextFormFileds(
                text: '',
                hintText: 'Add caption',
                labelText: 'Caption',
                cntrl: postCntrl.dicriptionCntrl),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.05,
                  decoration: BoxDecoration(
                      color: kBlackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: postCntrl.loadPost.value
                      ? Center(child: circularProgresKWhite)
                      : TextButton(
                          onPressed: () {
                            postCntrl.addPost();
                          },
                          child: const Text(
                            'Post',
                            style: normalTextStyleWhite,
                          )),
                ),
              ),
            )
          ],
        ));
  }
}

class PostImagePickWidget extends StatelessWidget {
  PostImagePickWidget({super.key, required this.size});
  final Size size;
  final postcntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhiteColor,
      child: Center(
        child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              postcntrl.time = DateTime.now();
                              postcntrl.imgPick(ImageSource.camera);
                              Get.back();
                            },
                            icon: const Icon(Icons.camera_alt)),
                        const Text(
                          'Camera',
                          style: normalTextStyleBlack,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              postcntrl.time = DateTime.now();
                              postcntrl.imgPick(ImageSource.gallery);
                              Get.back();
                            },
                            icon: const Icon(Icons.photo)),
                        const Text(
                          'Gellery',
                          style: normalTextStyleBlack,
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            iconSize: size.width * 0.1,
            icon: const Icon(
              Icons.add_circle_outline_sharp,
            )),
      ),
    );
  }
}
