import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/controller/search_controller.dart';
import 'package:fusion_sync/view/search/widgets/inital_screen.dart';
import 'package:get/get.dart';
import 'widgets/search_result.dart';
import 'widgets/search_textfiled.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchCntrl = Get.put(SearchCntrl());
  final profilCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    searchCntrl.getAllUsers();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchTextFormFiled(searchCntrl: searchCntrl),
            Obx(() {
              return searchCntrl.searchString.value == ""
                  ? Flexible(child: InitalStageScreen())
                  : Flexible(
                      child: SearchResultWidget(
                          searchCntrl: searchCntrl, profilCntrl: profilCntrl));
            })
          ],
        ),
      ),
    );
  }
}
