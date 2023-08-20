import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/search_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchCntrl = Get.put(SearchCntrl());
  @override
  Widget build(BuildContext context) {
    searchCntrl.getAllUsers();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  searchCntrl.searchUserGet(value);
                },
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchCntrl.searchList.clear();
                        },
                        icon: const Icon(Icons.cancel)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Flexible(
                child: Padding(
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
                    return Card(
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
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
