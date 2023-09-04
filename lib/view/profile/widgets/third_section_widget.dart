import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class ThirdSection extends StatelessWidget {
  ThirdSection({
    super.key,
  });
  final procntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: procntrl.getInstance
                  .doc(procntrl.auth.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data['name'] == ''
                            ? ''
                            : snapshot.data['name'],
                        style: normalTextStyleBlack,
                      )
                    : Text(
                        "username",
                        style: normalTextStyleBlack,
                      );
              }),
          StreamBuilder(
              stream: procntrl.getInstance
                  .doc(procntrl.auth.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data['bio'] == '' ? '' : snapshot.data['bio'],
                        style: normalTextStyleBlack,
                      )
                    : Text(
                        "bio",
                        style: normalTextStyleBlack,
                      );
              }),
        ],
      ),
    );
  }
}
