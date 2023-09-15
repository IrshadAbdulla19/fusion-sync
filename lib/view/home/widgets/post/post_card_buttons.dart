import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/home/widgets/post/comment.dart';
import 'package:fusion_sync/view/home/widgets/post/liked_users.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PostCardLikeBottomItems extends StatelessWidget {
  PostCardLikeBottomItems({
    super.key,
    required this.likes,
    required this.text,
    required this.postId,
    required this.postUserId,
  });
  final postCntrl = Get.put(PostController());
  List likes;
  String text;
  String postId;
  String postUserId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              postCntrl.likePost(postCntrl.auth.currentUser?.uid ?? 'userid',
                  postUserId, postId, likes);
              postCntrl.likeUserDetiles(postUserId, postId);
            },
            icon: likes.contains(postCntrl.auth.currentUser?.uid)
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border)),
        GestureDetector(
          onTap: () => Get.to(() => LikedUsers(likes: likes)),
          child: Text(
            text,
            style: normalTextStyleBlack,
          ),
        )
      ],
    );
  }
}

class PostCardCommentBottomItems extends StatelessWidget {
  PostCardCommentBottomItems({
    super.key,
    required this.icon,
    required this.text,
    required this.postId,
    required this.postUserId,
  });
  IconData icon;
  String text;
  String postId;
  String postUserId;
  final postCntrl = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () async {
              await postCntrl.postCommentDetiles(postUserId, postId);
              Get.to(CommentScreen(
                postId: postId,
                postUserId: postUserId,
              ));
            },
            icon: Icon(icon)),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}

class PostCardBottomItems extends StatelessWidget {
  PostCardBottomItems(
      {super.key,
      required this.icon,
      required this.text,
      required this.photoUrl});
  IconData icon;
  String text;
  String photoUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () async {
              final imgUrl = photoUrl;
              final url = Uri.parse(imgUrl);
              final response = await http.get(url);
              final byte = response.bodyBytes;
              final temp = await getTemporaryDirectory();
              final path = '${temp.path}/image.jpg';
              print(path);
              File(path).writeAsBytesSync(byte);
              await Share.shareFiles([path],
                  text: 'Image', subject: 'something to share');
            },
            icon: Icon(icon)),
        Text(
          text,
          style: normalTextStyleBlack,
        )
      ],
    );
  }
}
