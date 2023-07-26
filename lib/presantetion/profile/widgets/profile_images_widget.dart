import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class ProfileImagesWidget extends StatelessWidget {
  const ProfileImagesWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.37,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: size.height * 0.28,
              decoration: BoxDecoration(
                  color: kBlackColor,
                  image: DecorationImage(
                      image: AssetImage(
                        "asset/images/post 7.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
              right: size.width * 0.008,
              bottom: size.height * 0.095,
              child: CircleAvatar(
                backgroundColor: kWhiteColor,
                child:
                    IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: AssetImage("asset/images/user profile.webp"),
              radius: size.width * 0.23,
            ),
          ),
          Positioned(
              right: size.width * 0.3,
              bottom: size.height * 0.005,
              child: CircleAvatar(
                backgroundColor: kWhiteColor,
                child:
                    IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
              )),
        ],
      ),
    );
  }
}
