import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                        Text(
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
                        Text(
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
