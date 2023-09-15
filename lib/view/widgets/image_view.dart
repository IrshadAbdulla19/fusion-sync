import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  PhotoViewScreen({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(imageProvider: NetworkImage(image)),
    );
  }
}
