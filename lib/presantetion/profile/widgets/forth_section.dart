import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/profile/extra_widgets/edit_profile/edit_profile_screen.dart';

class FourthSection extends StatelessWidget {
  const FourthSection({
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilScreen(),
                      ));
                },
                child: const Text(
                  "Edit Profile",
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
                icon: const Icon(Icons.person_add_alt_1)),
          ),
        ],
      ),
    );
  }
}
