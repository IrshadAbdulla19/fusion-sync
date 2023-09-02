import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:fusion_sync/model/ui_constants/storie_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorieController extends GetxController {
  final navCntrl = Get.put(NavController());
  TextEditingController storieTxtCntrl = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime? time;
  String photoUrl = '';
  Uint8List? _imgage;
  var load = false.obs;
  var loadPost = false.obs;
  var imgFile = ''.obs;
  String? img;
// -------------------------------Storie list-----------------------------------

  RxList storieList = [].obs;
  getAllStorieOfuser() async {
    storieList.value.clear();
    QuerySnapshot<Map<String, dynamic>> userGet =
        await _firestore.collection('stories').get();
    for (var element in userGet.docs) {
      if (element['StorieUserId'] != auth.currentUser!.uid) {
        storieList.value.add(element);
        storieList.refresh();
      }
    }
  }

// --------------------------------For add stories------------------------------

  Timer? deleteTimer;
  addStorie(String userId) async {
    loadPost.value = true;
    await saveImgToFireBase();
    final newPost = StorieModel(
        imgUrl: photoUrl, time: time, storieUserId: auth.currentUser!.uid);
    try {
      await _firestore.collection("stories").doc(userId).set(newPost.toMap());

      loadPost.value = false;
      photoUrl = '';
      imgFile.value = '';
      Get.back();
      navCntrl.index.value = 0;
      deleteTimer = Timer(const Duration(seconds: 24 * 60 * 60), () async {
        await _firestore.collection("stories").doc(userId).delete();
        await getAllStorieOfuser();
        deleteTimer?.cancel();
        print('Document deleted after 24 hours.');
      });
    } catch (e) {
      loadPost.value = false;
      Get.snackbar("Erorr", "storie posting error $e");
    }
  }

// --------------------------------Delete storie-------------------------------

  autodeletStory() async {
    final sdata = await _firestore.collection('stories').get();
    for (var element in sdata.docs) {
      Timestamp time = element['Time'];
      int now = DateTime.now().millisecondsSinceEpoch;
      final duration = now - time.millisecondsSinceEpoch;
      // 86400000
      if (duration > 86400000) {
        _firestore.collection("stories").doc(element['userid']).delete();
      }
    }
  }

// ----------------------------for save images to firebase----------------------
  saveImgToFireBase() async {
    if (_imgage != null) {
      img = await upLoadImageToStorage("userPost", _imgage!);

      if (img != null) {
        photoUrl = img!;
      }
    }
  }

  imgPick(
    ImageSource source,
  ) async {
    load.value = true;
    _imgage = await pickImage(source);
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      imgFile.value = _file.path;
      load.value = false;
      return await _file.readAsBytes();
    }
    Get.snackbar("Failed", "NO image is selected");
  }

  Future<String> upLoadImageToStorage(String childName, Uint8List file) async {
    var unique = time?.microsecondsSinceEpoch;
    print('the current time is $unique');
    Reference ref = _storage.ref().child(childName).child(time.toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downLoadUrl = await snap.ref.getDownloadURL();
    load.value = false;
    return downLoadUrl;
  }
}
