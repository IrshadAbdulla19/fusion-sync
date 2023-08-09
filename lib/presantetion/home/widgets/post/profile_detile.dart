import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class PostPofilePart extends StatelessWidget {
  PostPofilePart(
      {super.key,
      required this.size,
      required this.image,
      required this.username});

  final Size size;
  String image;
  String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: kBlackColor,
          backgroundImage: NetworkImage(image == '' ? userNonProfile : image),
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        Text(
          username,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}
