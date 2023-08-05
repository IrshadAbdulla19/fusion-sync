import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, username, name, email, profilePic, cover, bio, uid;
  List followers;
  List following;
  UserModel(
      {this.id,
      this.uid,
      this.email,
      this.username,
      this.profilePic,
      this.cover,
      this.bio,
      required this.followers,
      required this.following,
      this.name});
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
        email: map['email'],
        username: map['username'],
        id: map.id,
        followers: map['Followers'],
        following: map['Following']);
  }

  Map<String, dynamic> tomap() {
    return {
      'email': email,
      'username': username,
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'cover': cover,
      'bio': bio,
      'Followers': [],
      'Following': []
    };
  }
}
