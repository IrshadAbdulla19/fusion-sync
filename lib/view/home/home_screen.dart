import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/home/widgets/fusion_sync_logo.dart';
import 'package:fusion_sync/view/home/widgets/post/post_widget.dart';
import 'package:fusion_sync/view/home/widgets/storie_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final postCntrl = Get.put(PostController());
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: FusionSync(
            size: size,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                iconSize: size.width * 0.08,
                color: kBlackColor,
                icon: const Icon(Icons.message))
          ],
        ),
        body: RefreshIndicator(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                StoriePart(size: size),
                Flexible(child: ListOfPosts(size: size))
              ],
            ),
          ),
          onRefresh: () async {
            postCntrl.allUsresPostDetiles();
          },
        ));
  }
}

class ListOfPosts extends StatelessWidget {
  ListOfPosts({
    super.key,
    required this.size,
  });
  final postCntrl = Get.put(PostController());
  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? Obx(
                () => ListView.builder(
                  itemCount: postCntrl.allPost.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var username = '';
                    var profileUrl = '';
                    var userPostData = postCntrl.allPost[index];
                    var image = userPostData['photoUrl'];
                    var likes = userPostData['like'];
                    var postId = userPostData['postId'];
                    var postUserId = userPostData['uid'];
                    String time = postCntrl
                        .dateTimeFormatChange(userPostData['time'].toDate());
                    var description = userPostData['decription'];
                    for (var element in snapshot.data.docs) {
                      if (element['uid'] == userPostData['uid']) {
                        username = element['username'];
                        profileUrl = element['profilePic'];
                        break;
                      }
                    }
                    return PostWidget(
                      likes: likes,
                      size: size,
                      image: image,
                      time: time,
                      postId: postId,
                      postUserId: postUserId,
                      description: description,
                      username: username,
                      profileUrl: profileUrl,
                    );
                  },
                ),
              )
            : SizedBox(
                width: size.width * 0.5,
                height: size.height * 0.5,
                child: Center(
                  child: circularProgresKBlack,
                ),
              );
      },
    );
  }
}
