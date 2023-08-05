import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fusion_sync/application/auth_controller.dart';
import 'package:fusion_sync/application/profile_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagesWidget extends StatelessWidget {
  ProfileImagesWidget({
    super.key,
    required this.size,
  });
  final Size size;
  final procntrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.37,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: StreamBuilder(
                stream: procntrl.getInstance
                    .doc(procntrl.auth.currentUser?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? Container(
                          width: double.infinity,
                          height: size.height * 0.28,
                          decoration: snapshot.data['cover'] == ''
                              ? const BoxDecoration(
                                  color: kBlackColor,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "asset/images/cover blank.jpg",
                                      ),
                                      fit: BoxFit.fill))
                              : BoxDecoration(
                                  color: kBlackColor,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data['cover'],
                                      ),
                                      fit: BoxFit.cover)),
                        )
                      : circularProgresKWhite;
                }),
          ),
          Positioned(
              right: size.width * 0.008,
              bottom: size.height * 0.095,
              child: ImagePickWidget(type: 'cover')),
          Align(
            alignment: Alignment.bottomCenter,
            child: StreamBuilder(
                stream: procntrl.getInstance
                    .doc(procntrl.auth.currentUser?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? CircleAvatar(
                          backgroundImage: snapshot.data['profilePic'] == ''
                              ? const AssetImage(
                                  "asset/images/profile blank.webp")
                              : NetworkImage(snapshot.data['profilePic'])
                                  as ImageProvider,
                          radius: size.width * 0.23,
                        )
                      : CircleAvatar(
                          radius: size.width * 0.23,
                          child: circularProgresKWhite);
                }),
          ),
          Positioned(
              right: size.width * 0.3,
              bottom: size.height * 0.005,
              child: ImagePickWidget(type: 'profile')),
        ],
      ),
    );
  }
}

class ImagePickWidget extends StatelessWidget {
  ImagePickWidget({super.key, required this.type});
  String type;
  final procntrl = Get.put(ProfileController());
  final authcntrl = Get.put(AuthController());

  String? img;
  imgPick(ImageSource source, String type) async {
    Uint8List _imgage = await procntrl.pickImage(source);
    if (_imgage != null && type == 'profile') {
      img = await procntrl.upLoadImageToStorage("profilePics", _imgage);

      if (img != null) {
        procntrl.photoUrl = img!;
        procntrl.addUserProfile();
      }
    }
    if (_imgage != null && type == 'cover') {
      img = await procntrl.upLoadImageToStorage("coverPic", _imgage);

      if (img != null) {
        procntrl.coverPhotoUrl = img!;
        procntrl.addUserCover();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kWhiteColor,
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
                            imgPick(ImageSource.camera, type);
                          },
                          icon: Icon(Icons.camera_alt)),
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
                            imgPick(ImageSource.gallery, type);
                          },
                          icon: Icon(Icons.photo)),
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
          icon: Icon(Icons.camera_alt)),
    );
  }
}
