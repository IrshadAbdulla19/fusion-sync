import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class PostCardBottomItems extends StatelessWidget {
  PostCardBottomItems({super.key, required this.icon, required this.text});
  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(icon)),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}
