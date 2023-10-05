import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/controller/search_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({
    super.key,
    required this.searchCntrl,
    required this.profilCntrl,
  });

  final SearchCntrl searchCntrl;
  final ProfileController profilCntrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: searchCntrl.searchList.length,
          itemBuilder: (context, index) {
            var user = searchCntrl.searchList[index];
            String username = user['username'];
            String profile = user['profilePic'];
            String uid = user['uid'];
            String cover = user['cover'];
            return GestureDetector(
              onTap: () {
                profilCntrl.otherUserDetiles(uid);
              },
              child: SearchResultItem(
                  size: size,
                  cover: cover,
                  profile: profile,
                  username: username),
            );
          },
        ),
      ),
    );
  }
}

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    super.key,
    required this.size,
    required this.cover,
    required this.profile,
    required this.username,
  });

  final Size size;
  final String cover;
  final String profile;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.width * 0.02, horizontal: size.width * 0.015),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 4, blurStyle: BlurStyle.outer),
        ],
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: SizedBox(
          width: double.infinity,
          height: size.height * 0.2,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.width * 0.03),
                        topRight: Radius.circular(size.width * 0.03)),
                    image: DecorationImage(
                        image: NetworkImage(cover == '' ? noImage : cover),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                left: size.width * 0.04,
                bottom: size.height * 0.02,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: size.width * 0.3,
                      height: size.height * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                  profile == '' ? nonUserNonProfile : profile),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      username,
                      style: normalTextStyleBlack,
                    )
                  ],
                ),
              ),
            ],
          )
          // (

          //   backgroundImage:
          // ),
          // title: Text(
          //   username,
          //   style: normalTextStyleBlack,
          // ),
          ),
    );
  }
}
