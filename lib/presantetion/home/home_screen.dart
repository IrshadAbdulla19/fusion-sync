import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/home/widgets/fusion_sync_logo.dart';
import 'package:fusion_sync/presantetion/home/widgets/post/post_widget.dart';
import 'package:fusion_sync/presantetion/home/widgets/storie_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: FusionSync(
            size: size,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                iconSize: size.width * 0.08,
                color: kBlackColor,
                icon: const Icon(Icons.message))
          ],
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              StoriePart(size: size),
              Flexible(child: ListOfPosts(size: size))
            ],
          ),
        ));
  }
}

class ListOfPosts extends StatelessWidget {
  ListOfPosts({
    super.key,
    required this.size,
  });

  final Size size;
  var images = [
    "asset/images/post 6.jpeg",
    "asset/images/post 5.jpeg",
    "asset/images/post 7.jpg",
    "asset/images/post 8.webp"
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var image = images[index];
        return PostWidget(
          size: size,
          image: image,
        );
      },
    );
  }
}
