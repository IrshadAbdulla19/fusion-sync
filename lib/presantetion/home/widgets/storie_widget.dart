import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class StoriePart extends StatelessWidget {
  StoriePart({
    super.key,
    required this.size,
  });

  final Size size;
  var images = [
    "asset/images/post 6.jpeg",
    "asset/images/post 5.jpeg",
    "asset/images/post 7.jpg",
    "asset/images/post 8.webp",
    "asset/images/post.jpeg",
    "asset/images/user profile.webp",
    "asset/images/post 6.jpeg",
    "asset/images/post 5.jpeg",
    "asset/images/post 7.jpg",
    "asset/images/post 8.webp",
    "asset/images/post.jpeg",
    "asset/images/user profile.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height * 0.07,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 12,
            itemBuilder: (context, index) {
              var image = images[index];
              return CircleAvatar(
                backgroundImage: AssetImage(image),
                backgroundColor: kBlackColor,
                radius: size.width * 0.083,
              );
            }));
  }
}
