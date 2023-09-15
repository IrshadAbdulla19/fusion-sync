import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/controller/search_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class InitalStageScreen extends StatelessWidget {
  InitalStageScreen({super.key});
  final searchCntrl = Get.put(SearchCntrl());
  final profileCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => GridView.builder(
          itemCount: searchCntrl.alluser.value.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 1, crossAxisSpacing: 4),
          itemBuilder: (context, index) {
            var user = searchCntrl.alluser[index];
            var profile = '';
            var username = '';
            var bio = '';
            var cover = '';
            var uid = '';
            try {
              profile = user['profilePic'];
              username = user['username'];
              bio = user['bio'];
              uid = user['uid'];
              cover = user['cover'];
            } catch (e) {}
            return GestureDetector(
              onTap: () {
                profileCntrl.otherUserDetiles(uid);
              },
              child: InitalStageItem(
                size: size,
                profile: profile,
                username: username,
                bio: bio,
                cover: cover,
              ),
            );
          }),
    );
  }
}

class InitalStageItem extends StatelessWidget {
  const InitalStageItem(
      {super.key,
      required this.size,
      required this.profile,
      required this.username,
      required this.bio,
      required this.cover});
  final Size size;
  final String profile;
  final String username;
  final String bio;
  final String cover;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.black,
      elevation: 2,
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(cover == '' ? noImage : cover),
                      fit: BoxFit.cover)),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(
                                profile == '' ? nonUserNonProfile : profile),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    username,
                    style: normalTextStyleBlack,
                  ),
                  Text(
                    bio,
                    style: normalTextStyleBlack,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
