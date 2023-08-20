import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchCntrl extends GetxController {
  final FirebaseFirestore _firestroe = FirebaseFirestore.instance;
  RxList searchList = [].obs;
  List alluser = [];

  getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> getusers =
        await _firestroe.collection('user').get();
    alluser = getusers.docs;
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
