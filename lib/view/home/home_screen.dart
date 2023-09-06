import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/controller/storie_controller.dart';
import 'package:fusion_sync/view/home/widgets/app_bar.dart';
import 'package:fusion_sync/view/home/widgets/post/all_post_list.dart';
import 'package:fusion_sync/view/home/widgets/storie_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final postCntrl = Get.put(PostController());
  final profileCntrl = Get.put(ProfileController());
  final stryCntrl = Get.put(StorieController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.08),
            child: HomeAppBar(size: size),
          ),
          body: RefreshIndicator(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: StoriePart(size: size)),
                  Flexible(child: ListOfPosts(size: size))
                ],
              ),
            ),
            onRefresh: () async {
              postCntrl.allUsresPostDetiles();
              postCntrl.thisUserDetiles();
              stryCntrl.getAllStorieOfuser();
            },
          )),
    );
  }
}
