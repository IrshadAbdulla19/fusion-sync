import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCntrl extends GetxController {
  final FirebaseFirestore _firestroe = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchCntrl = TextEditingController();
  RxList searchList = [].obs;
  List alluser = [];

  getAllUsers() async {
    searchList.clear();
    alluser.clear();
    final currentUserId = auth.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> getusers =
        await _firestroe.collection('user').get();
    try {
      for (var element in getusers.docs) {
        if (element['uid'] != currentUserId) {
          alluser.add(element);
        }
      }
    } catch (e) {
      print("the erorr is $e");
    }
  }

  searchUserGet(String name) async {
    searchList.value = alluser
        .where((element) => element['username']
            .toString()
            .toLowerCase()
            .contains(name.toLowerCase()))
        .toList();
    searchList.refresh();
  }
}
