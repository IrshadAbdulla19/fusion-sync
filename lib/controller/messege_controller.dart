import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/model/messege_model.dart';
import 'package:get/get.dart';

class MessegeController extends GetxController {
  TextEditingController messageCntrl = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var getUsersChatList =
      FirebaseFirestore.instance.collection('chat_users_list');

// --------------------------for get All/users----------------------------------

  RxList<DocumentSnapshot> allUserDetiles = <DocumentSnapshot>[].obs;

  allUsersGet() async {
    try {
      QuerySnapshot getusers =
          await FirebaseFirestore.instance.collection('user').get();
      allUserDetiles.value = getusers.docs;
      allUserDetiles.refresh();
    } catch (e) {
      print('error');
    }
  }

  // ----------------------------for messege sent-------------------------------

  sendMessage(String receviersId) async {
    final currentUserId = auth.currentUser!.uid;
    final time = DateTime.now();

    final newMessage = MessegeModel(
        messege: messageCntrl.text,
        senderId: currentUserId,
        receiverId: receviersId,
        time: time);

    List<String> ids = [currentUserId, receviersId];
    ids.sort();
    String chatId = ids.join("_");
    await _firestore
        .collection('chat_collection')
        .doc(chatId)
        .collection('messages')
        .add(newMessage.toMap());

    DocumentSnapshot snap =
        await _firestore.collection('chat_users_list').doc(currentUserId).get();
    List chatingList = (snap.data() as dynamic)['ChatList'];
    if (chatingList.contains(receviersId)) {
      await _firestore.collection('chat_users_list').doc(currentUserId).update({
        'ChatList': FieldValue.arrayRemove([receviersId])
      });
      await _firestore.collection('chat_users_list').doc(currentUserId).update({
        'ChatList': FieldValue.arrayUnion([receviersId])
      });
      await _firestore.collection('chat_users_list').doc(receviersId).update({
        'ChatList': FieldValue.arrayRemove([currentUserId])
      });
      await _firestore.collection('chat_users_list').doc(receviersId).update({
        'ChatList': FieldValue.arrayUnion([currentUserId])
      });
    } else {
      await _firestore.collection('chat_users_list').doc(currentUserId).update({
        'ChatList': FieldValue.arrayUnion([receviersId])
      });
      await _firestore.collection('chat_users_list').doc(receviersId).update({
        'ChatList': FieldValue.arrayUnion([currentUserId])
      });
    }
  }
// ------------------------get message------------------------------------------

  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    List<String> ids = [otherUserId, userId];
    ids.sort();
    String chatId = ids.join("_");
    print("-----------------------------$chatId----------------------------");
    return _firestore
        .collection('chat_collection')
        .doc(chatId)
        .collection('messages')
        .orderBy('Time', descending: false)
        .snapshots();
  }

  RxList searchList = [].obs;
  List alluser = [];
  getAllUsers() async {
    alluser.clear();
    final currentUserId = auth.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> getusers =
        await _firestore.collection('user').get();
    for (var element in getusers.docs) {
      if (element['uid'] != currentUserId) {
        alluser.add(element);
      }
    }

    searchList.value = alluser;
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
