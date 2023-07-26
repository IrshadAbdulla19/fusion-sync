import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class ThirdSection extends StatelessWidget {
  const ThirdSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Irshad",
            style: normalTextStyleBlack,
          ),
          Text(
            "Flutter Developer",
            style: normalTextStyleBlack,
          ),
          Text(
            "Kochi Kearala",
            style: normalTextStyleBlack,
          ),
        ],
      ),
    );
  }
}
