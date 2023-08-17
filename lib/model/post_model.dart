import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id, photoUrl, decription, postId, uid;
  DateTime? time;
  List? like;

  PostModel(
      {this.id,
      this.photoUrl,
      this.decription,
      this.uid,
      this.time,
      this.postId,
      this.like});

  factory PostModel.fromMap(DocumentSnapshot map) {
    return PostModel(
        photoUrl: map['photoUrl'],
        decription: map['decription'],
        uid: map['uid'],
        time: map['time'],
        id: map.id,
        postId: map['postId'],
        like: map['like']);
  }

  Map<String, dynamic> tomap() {
    return {
      'photoUrl': photoUrl,
      'decription': decription,
      'time': time,
      'uid': uid,
      'postId': postId,
      'like': []
    };
  }
}
