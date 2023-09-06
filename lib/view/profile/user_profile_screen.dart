import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/view/profile/widgets/app_bar.dart';
import 'package:fusion_sync/view/profile/widgets/forth_section.dart';
import 'package:fusion_sync/view/profile/widgets/post_top_widget.dart';
import 'package:fusion_sync/view/profile/widgets/profile_images_widget.dart';
import 'package:fusion_sync/view/profile/widgets/profile_post_widget.dart';
import 'package:fusion_sync/view/profile/widgets/second_section_profile.dart';
import 'package:fusion_sync/view/profile/widgets/third_section_widget.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: ProfileAppBar(
              contxt: context,
              size: size,
            )),
        body: RefreshIndicator(
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileImagesWidget(
                    size: size,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SecondSection(),
                  ThirdSection(),
                  FourthSection(size: size),
                  PostsTopPart(),
                  ProfilePosts()
                ],
              )),
          onRefresh: () async {
            postCntrl.thisUserDetiles();
          },
        ));
  }
}
