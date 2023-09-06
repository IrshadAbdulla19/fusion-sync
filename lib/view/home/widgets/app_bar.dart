import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/home/widgets/fusion_sync_logo.dart';
import 'package:fusion_sync/view/home/widgets/messege/messege.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FusionSync(
          size: size,
        ),
        Spacer(),
        IconButton(
            onPressed: () {
              Get.to(() => MessegeScreen());
            },
            iconSize: size.width * 0.08,
            color: kBlackColor,
            icon: const Icon(Icons.message))
      ],
    );
  }
}
