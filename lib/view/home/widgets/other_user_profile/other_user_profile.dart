import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/profile/widgets/counts_in_profil.dart';
import 'package:fusion_sync/view/profile/widgets/profile_post_widget.dart';
import 'package:get/get.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                            profileCntrl.otheUserCover.value,
                          ),
                          fit: BoxFit.cover)))),
          Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(profileCntrl.otheUserProfile.value),
                radius: size.width * 0.23,
              )),
        ],
      ),
    );
  }
}

class UsersSecondSection extends StatelessWidget {
  const UsersSecondSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CountsInProfile(
          num: '3',
          text: "Posts",
        ),
        CountsInProfile(
          num: "0",
          text: "Followers",
        ),
        CountsInProfile(
          num: "0",
          text: "Following",
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
              profileCntrl.otheUserName.value,
              style: normalTextStyleBlack,
            ),
          ),
          Text(
            profileCntrl.otheUserbio.value,
            style: normalTextStyleBlack,
          ),
        ],
      ),
    );
  }
}

class OthersFourthSection extends StatelessWidget {
  const OthersFourthSection({
    super.key,
    required this.size,
  });

  final Size size;

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
                onPressed: () {},
                child: const Text(
                  "Following",
                  style: normalTextStyleWhite,
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
  const UsersProfilePosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        itemCount: 4,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: ProfilePostWidget(
              image:
                  'https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?cs=srgb&dl=pexels-pixabay-268533.jpg&fm=jpg',
            ),
          );
        },
      ),
    );
  }
}
