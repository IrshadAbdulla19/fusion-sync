import 'package:flutter/material.dart';
import 'package:fusion_sync/application/profile_controller.dart';
import 'package:fusion_sync/presantetion/profile/widgets/counts_in_profil.dart';
import 'package:get/get.dart';

class SecondSection extends StatelessWidget {
  SecondSection({
    super.key,
  });
  final proCntrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CountsInProfile(
          num: "4",
          text: "Posts",
        ),
        StreamBuilder(
            stream: proCntrl.getInstance
                .doc(proCntrl.auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? CountsInProfile(
                      num: snapshot.data['Followers'].length.toString(),
                      text: "Followers",
                    )
                  : CountsInProfile(
                      num: "0",
                      text: "Followers",
                    );
            }),
        StreamBuilder(
            stream: proCntrl.getInstance
                .doc(proCntrl.auth.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? CountsInProfile(
                      num: snapshot.data['Following'].length.toString(),
                      text: "Following",
                    )
                  : CountsInProfile(
                      num: "0",
                      text: "Following",
                    );
            }),
      ],
    );
  }
}
