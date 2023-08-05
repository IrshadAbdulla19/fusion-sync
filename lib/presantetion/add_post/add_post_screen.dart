import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/widgets/for_textfileds.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  String? image;
  TextEditingController captionCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              color: kBlackColor,
              iconSize: size.height * 0.05,
              icon: const Icon(Icons.close)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "New Post",
            style: mainTextHeads,
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          image ??
                              'https://img.freepik.com/premium-photo/top-view-abstract-paper-texture-background_225709-2718.jpg?w=2000',
                          scale: 1.2),
                      fit: BoxFit.cover)),
              child: IconButton(
                  onPressed: () {},
                  iconSize: size.height * 0.08,
                  icon: const Icon(Icons.add_circle_outline_sharp)),
            ),
            ForTextFormFileds(
                text: 'Capstion',
                hintText: 'Add caption',
                labelText: 'Caption',
                cntrl: captionCntrl),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: normalTextStyleWhite,
                ))
          ],
        ));
  }
}
