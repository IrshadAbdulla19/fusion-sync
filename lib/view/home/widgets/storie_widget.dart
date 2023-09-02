import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/controller/storie_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StoriePart extends StatelessWidget {
  StoriePart({
    super.key,
    required this.size,
  });
  final prflCntrl = Get.put(ProfileController());
  final stryCntrl = Get.put(StorieController());
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      backgroundImage: NetworkImage(
                          prflCntrl.profile.value == ""
                              ? nonUserNonProfile
                              : prflCntrl.profile.value),
                      backgroundColor: kBlackColor,
                      radius: size.width * 0.083,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: size.width * 0.04,
                      child: IconButton(
                          iconSize: size.width * 0.04,
                          onPressed: () {
                            Get.to(() => AddStorieScreen());
                          },
                          color: kWhiteColor,
                          icon: Icon(Icons.add)),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Obx(
                () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: false,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: stryCntrl.storieList.length,
                    itemBuilder: (context, index) {
                      var storie = stryCntrl.storieList[index];
                      var image = storie['ImageUrl'];
                      var storieUserid = storie['StorieUserId'];
                      return InkWell(
                        onTap: () => Get.to(() => StorieView(
                              image: image,
                            )),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          backgroundColor: kBlackColor,
                          radius: size.width * 0.083,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}

class StorieView extends StatefulWidget {
  StorieView({super.key, required this.image});
  String image;

  @override
  State<StorieView> createState() => _StorieViewState();
}

class _StorieViewState extends State<StorieView> {
  double precent = 0.0;
  late Timer _timer;

  void startTime() {
    _timer = Timer.periodic(const Duration(milliseconds: 3), (timer) {
      setState(() {
        precent += 0.001;
        if (precent > 1) {
          _timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: kBlackColor,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.image))),
            ),
            LinearProgressIndicator(
              value: precent,
              backgroundColor: kWhiteColor,
            )
          ],
        ),
      ),
    );
  }
}

class AddStorieScreen extends StatelessWidget {
  AddStorieScreen({super.key});

  final stryCntrl = Get.put(StorieController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                stryCntrl.imgFile.value = '';
                stryCntrl.photoUrl = '';
              },
              color: kBlackColor,
              iconSize: size.height * 0.05,
              icon: const Icon(Icons.close)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Add Storie",
            style: mainTextHeads,
          ),
        ),
        body: ListView(
          children: [
            Obx(
              () => stryCntrl.imgFile.value != ""
                  ? Container(
                      width: double.infinity,
                      height: size.height * 0.6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(stryCntrl.imgFile.value)),
                              fit: BoxFit.cover)),
                      child: stryCntrl.load.value
                          ? circularProgresKBlack
                          : const SizedBox(),
                    )
                  : Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: size.height * 0.6,
                      child: StorieImagePickWidget(
                        size: size,
                      )),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.05,
                  decoration: BoxDecoration(
                      color: kBlackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: stryCntrl.loadPost.value
                      ? const Center(child: circularProgresKWhite)
                      : TextButton(
                          onPressed: () {
                            stryCntrl
                                .addStorie(stryCntrl.auth.currentUser!.uid);
                          },
                          child: const Text(
                            'Post',
                            style: normalTextStyleWhite,
                          )),
                ),
              ),
            ),
          ],
        ));
  }
}

class StorieImagePickWidget extends StatelessWidget {
  StorieImagePickWidget({super.key, required this.size});
  final Size size;
  final strycntrl = Get.put(StorieController());

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
                              strycntrl.time = DateTime.now();
                              strycntrl.imgPick(ImageSource.camera);
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
                              strycntrl.time = DateTime.now();
                              strycntrl.imgPick(ImageSource.gallery);
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
