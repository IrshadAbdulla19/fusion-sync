import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  TextEditingController usernamecntrl = TextEditingController();
  TextEditingController namecntrl = TextEditingController();
  TextEditingController biocntrl = TextEditingController();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? photoUrl;
  String? coverPhotoUrl;
  String profile = userNonProfile;
  String name = '';
  String bio = '';
  String username = '';
  String email = '';

  var getInstance = FirebaseFirestore.instance.collection('user');

  userDetiles() async {
    try {
      Stream<DocumentSnapshot<Map<String, dynamic>>> user =
          getInstance.doc(auth.currentUser?.uid).snapshots();
      var userData;
      user.listen((snapshot) async {
        if (snapshot.exists) {
          userData = snapshot.data() as Map<String, dynamic>;
          name = await userData['name'];
          profile = await userData['profilePic'];
        }
      });
    } catch (e) {
      print('error $e');
    }
    print(name);
  }

  addUserProfile() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'profilePic': photoUrl,
    });
  }

  addUserCover() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'cover': coverPhotoUrl,
    });
  }

  profiletextEdit() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'name': namecntrl.text,
      'username': usernamecntrl.text,
      'bio': biocntrl.text,
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    Get.snackbar("Failed", "NO image is selected");
  }

  Future<String> upLoadImageToStorage(String childName, Uint8List file) async {
    var unique = DateTime.now();
    print('the current time is $unique');
    Reference ref =
        _storage.ref().child(childName).child(auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downLoadUrl = await snap.ref.getDownloadURL();

    return downLoadUrl;
  }
}
