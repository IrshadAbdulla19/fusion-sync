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
            return GestureDetector(
              onTap: () {
                profilCntrl.otherUserDetiles(uid);
              },
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        profile == '' ? nonUserNonProfile : profile),
                  ),
                  title: Text(
                    username,
                    style: normalTextStyleBlack,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
