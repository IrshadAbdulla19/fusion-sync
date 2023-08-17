import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/home/widgets/other_user_profile/other_user_profile.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  final navCntrlr = Get.put(NavController());
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

// ----------------for get current app users profile detiles--------------------------

  userDetiles() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> user =
          await getInstance.doc(auth.currentUser?.uid).get();
      Map<String, dynamic> userData;

      if (user.exists) {
        userData = user.data() as Map<String, dynamic>;
        username = await userData['username'];
        profile = await userData['profilePic'];
      }
    } catch (e) {
      print('error $e');
    }
  }

// ---------------------------for geting other users profile detiles--------------------

  var otheUserName = ''.obs;
  var otheUserbio = ''.obs;
  var otheUserUsername = ''.obs;
  var otheUserProfile = ''.obs;
  var otheUserCover = ''.obs;

  otherUserDetiles(String thisUserUid) async {
    if (thisUserUid == auth.currentUser?.uid) {
      navCntrlr.index.value = 4;
    } else {
      try {
        DocumentSnapshot<Map<String, dynamic>> user =
            await getInstance.doc(thisUserUid).get();
        Map<String, dynamic> userData = {};

        if (user.exists) {
          userData = user.data() as Map<String, dynamic>;
          otheUserUsername.value = await userData['username'];
          otheUserProfile.value = await userData['profilePic'];
          otheUserName.value = await userData['name'];
          otheUserbio.value = await userData['bio'];
          otheUserCover.value = await userData['cover'];

          print("other users deteiles are name is  ${otheUserUsername.value}");
          Get.to(() => const OtherUserProfile());
        } else {
          print("other user not exist for this");
        }
      } catch (e) {
        print('error $e');
      }
    }
  }

// ------------------------for adding profile photo--------------------------
  addUserProfile() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'profilePic': photoUrl,
    });
  }

// -------------------------for adding cover photo--------------------------

  addUserCover() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'cover': coverPhotoUrl,
    });
  }

// -----------------------for users profile editing------------------------

  profiletextEdit() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'name': namecntrl.text,
      'username': usernamecntrl.text,
      'bio': biocntrl.text,
    });
  }

// --------------------------for image pick from device ---------------------------

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
