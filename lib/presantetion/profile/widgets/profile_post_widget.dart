import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class ProfilePosts extends StatelessWidget {
  ProfilePosts({
    super.key,
  });
  var images = [
    "asset/images/post 6.jpeg",
    "asset/images/post 5.jpeg",
    "asset/images/post 7.jpg",
    "asset/images/post 8.webp"
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        itemCount: 4,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
        itemBuilder: (context, index) {
          var image = images[index];
          return ProfilePostWidget(
            image: image,
          );
        },
      ),
    );
  }
}

class ProfilePostWidget extends StatelessWidget {
  ProfilePostWidget({
    required this.image,
    super.key,
  });
  String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          color: kBlackColor),
    );
  }
}
