import 'package:flutter/material.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_card_buttons.dart';

class PostWidgetBottomPart extends StatelessWidget {
  const PostWidgetBottomPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PostCardBottomItems(
          icon: Icons.favorite_border,
          text: "18 Likes",
        ),
        PostCardBottomItems(
          icon: Icons.comment,
          text: "16 comments",
        ),
        PostCardBottomItems(
          icon: Icons.send,
          text: "Share",
        ),
      ],
    );
  }
}
