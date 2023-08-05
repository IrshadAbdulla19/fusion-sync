import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class PostPofilePart extends StatelessWidget {
  PostPofilePart({super.key, required this.size, required this.image});

  final Size size;
  String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: kBlackColor,
          backgroundImage: AssetImage(image),
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        Text(
          "Sahil Aslam",
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}
