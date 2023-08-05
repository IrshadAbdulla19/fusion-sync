import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_bottom_part.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_card.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.size, required this.image});

  final Size size;
  String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          PostCardTopPart(
            size: size,
            image: image,
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.4,
            decoration: BoxDecoration(
              color: kBlackColor,
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          PostWidgetBottomPart()
        ],
      ),
    );
  }
}
