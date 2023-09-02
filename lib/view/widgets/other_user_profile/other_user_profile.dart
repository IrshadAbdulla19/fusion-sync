import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/profile/widgets/counts_in_profil.dart';
import 'package:fusion_sync/view/profile/widgets/profile_post_widget.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class OtherUserProfile extends StatelessWidget {
  OtherUserProfile({super.key});
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          profileCntrl.otherUserUsername.value,
          style: normalTextStyleBlack,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OthersProfileImagesWidget(size: size),
              const SizedBox(
                height: 20,
              ),
              UsersSecondSection(),
              UsersThirdSection(),
              OthersFourthSection(size: size),
              const SizedBox(
                height: 20,
              ),
              UsersProfilePosts(),
            ],
          ),
        ),
      ),
    );
  }
}

class OthersProfileImagesWidget extends StatelessWidget {
  OthersProfileImagesWidget({
    super.key,
    required this.size,
  });
  final Size size;
  final profileCntrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.37,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: double.infinity,
                  height: size.height * 0.28,
                  decoration: BoxDecoration(
                      color: kBlackColor,
                      image: DecorationImage(
                          image: NetworkImage(
                            profileCntrl.otherUserCover.value == ''
                                ? nonUserNonProfile
                                : profileCntrl.otherUserCover.value,
                          ),
                          fit: BoxFit.cover)))),
          Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    profileCntrl.otherUserProfile.value == ''
                        ? nonUserNonProfile
                        : profileCntrl.otherUserProfile.value),
                radius: size.width * 0.23,
              )),
        ],
      ),
    );
  }
}

class UsersSecondSection extends StatelessWidget {
  UsersSecondSection({
    super.key,
  });
  final postCntrl = Get.put(PostController());
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CountsInProfile(
          num: postCntrl.otherUserPost.length.toString(),
          text: "Posts",
        ),
        InkWell(
          onTap: () => Get.to(() => FollowListWidget(
                followList: profileCntrl.followers,
                head: "Followers",
              )),
          child: Obx(
            () => CountsInProfile(
              num: profileCntrl.followers.length.toString(),
              text: "Followers",
            ),
          ),
        ),
        InkWell(
          onTap: () => Get.to(
            () => FollowListWidget(
                head: "Following", followList: profileCntrl.follwing),
          ),
          child: Obx(
            () => CountsInProfile(
              num: profileCntrl.follwing.length.toString(),
              text: "Following",
            ),
          ),
        ),
      ],
    );
  }
}

class UsersThirdSection extends StatelessWidget {
  UsersThirdSection({
    super.key,
  });
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              profileCntrl.otherUserName.value,
              style: normalTextStyleBlack,
            ),
          ),
          Text(
            profileCntrl.otherUserbio.value,
            style: normalTextStyleBlack,
          ),
        ],
      ),
    );
  }
}

class OthersFourthSection extends StatelessWidget {
  OthersFourthSection({
    super.key,
    required this.size,
  });

  final Size size;
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.4,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13), color: kBlackColor),
            child: TextButton(
                onPressed: () async {
                  await profileCntrl.followAndUnfollow(
                      profileCntrl.auth.currentUser?.uid ?? '',
                      profileCntrl.otherUserUid.value);
                  await profileCntrl.otherUserFollowListUpdate(
                      profileCntrl.otherUserUid.value);
                },
                child: Obx(
                  () => Text(
                    profileCntrl.followers
                            .contains(profileCntrl.auth.currentUser?.uid)
                        ? "Unfollow"
                        : "Follow",
                    style: normalTextStyleWhite,
                  ),
                )),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Container(
            width: size.width * 0.2,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: kBlackColor),
            child: IconButton(
                onPressed: () {},
                color: kWhiteColor,
                icon: const Icon(Icons.message)),
          ),
        ],
      ),
    );
  }
}

class UsersProfilePosts extends StatelessWidget {
  UsersProfilePosts({
    super.key,
  });
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        itemCount: postCntrl.otherUserPost.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
        itemBuilder: (context, index) {
          var userPostData = postCntrl.otherUserPost[index];
          var image = userPostData['photoUrl'];
          var description = userPostData['decription'];
          var postId = userPostData['postId'];
          return GestureDetector(
            onTap: () {
              Get.to(OtherUsersProfilePostView(
                description: description,
                image: image,
                postId: postId,
              ));
            },
            child: ProfilePostWidget(
              image: image,
            ),
          );
        },
      ),
    );
  }
}

class OtherUsersProfilePostView extends StatelessWidget {
  OtherUsersProfilePostView(
      {required this.image,
      super.key,
      required this.description,
      required this.postId});
  String image;
  String description;
  String postId;
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            description,
            style: normalTextStyleWhite,
          ),
        ),
        body: PhotoView(imageProvider: NetworkImage(image)));
  }
}

class FollowListWidget extends StatelessWidget {
  FollowListWidget({super.key, required this.head, required this.followList});
  final postCntrl = Get.put(PostController());
  String head;
  List followList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          head,
          style: normalTextStyleBlack,
        ),
      ),
      body: ListView.builder(
        itemCount: followList.length,
        itemBuilder: (context, index) {
          var user = followList[index];
          var profile = '';
          var username = '';
          var uid = '';
          for (var element in postCntrl.allUserDetiles) {
            if (element['uid'] == user) {
              profile = element['profilePic'];
              username = element['username'];
              uid = element['uid'];
            }
          }
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(profile == '' ? nonUserNonProfile : profile),
              ),
              title: Text(
                username,
                style: normalTextStyleBlack,
              ),
            ),
          );
        },
      ),
    );
  }
}
