import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class CountsInProfile extends StatelessWidget {
  CountsInProfile({
    required this.num,
    required this.text,
    super.key,
  });
  String num;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          num,
          style: normalTextStyleBlack,
        ),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}
