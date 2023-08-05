import 'package:flutter/material.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/profile_detile.dart';

class PostCardTopPart extends StatelessWidget {
  PostCardTopPart({super.key, required this.size, required this.image});

  final Size size;
  String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PostPofilePart(
          size: size,
          image: image,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
      ],
    );
  }
}
