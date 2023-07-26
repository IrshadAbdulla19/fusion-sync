import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id, username, email;
  UserModel({this.id, this.email, this.username});
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
        email: map['email'], username: map['username'], id: map.id);
  }

  Map<String, dynamic> tomap() {
    return {
      'email': email,
      'username': username,
    };
  }
}
