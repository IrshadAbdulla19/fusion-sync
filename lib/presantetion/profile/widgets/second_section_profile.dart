import 'package:flutter/material.dart';
import 'package:fusion_sync/presantetion/profile/widgets/counts_in_profil.dart';

class SecondSection extends StatelessWidget {
  const SecondSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CountsInProfile(
          num: "4",
          text: "Posts",
        ),
        CountsInProfile(
          num: "134",
          text: "Followers",
        ),
        CountsInProfile(
          num: "123",
          text: "Following",
        ),
      ],
    );
  }
}
