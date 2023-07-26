import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';

class PostsTopPart extends StatelessWidget {
  const PostsTopPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.image_outlined,
            size: 30,
          ),
          Text(
            "Posts",
            style: normalTextStyleBlack.copyWith(fontSize: 20),
          )
        ],
      ),
    );
  }
}
