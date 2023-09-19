import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PostView extends StatelessWidget {
  PostView(
      {required this.image,
      super.key,
      required this.description,
      required this.postId});
  String image;
  String description;
  String postId;

  var isExpanded = false.obs;

  void _toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Stack(
          children: [
            PhotoView(imageProvider: NetworkImage(image)),
            Align(
              alignment: Alignment.bottomLeft,
              child: Obx(
                () => GestureDetector(
                  onTap: _toggleExpansion,
                  child: AnimatedContainer(
                    color: Colors.black.withOpacity(0.5),
                    duration: Duration(milliseconds: 300),
                    width: double.infinity,
                    height: isExpanded.value ? size.height * 0.5 : 100.0,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          description,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
