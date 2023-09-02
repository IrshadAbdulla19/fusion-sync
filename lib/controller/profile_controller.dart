import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:fusion_sync/controller/notification_controller.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/widgets/other_user_profile/other_user_profile.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  final navCntrlr = Get.put(NavController());
  final postCntrl = Get.put(PostController());
  final notiCntrl = Get.put(NotificationController());
  TextEditingController usernamecntrl = TextEditingController();
  TextEditingController namecntrl = TextEditingController();
  TextEditingController biocntrl = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? photoUrl;
  String? coverPhotoUrl;
  var profile = nonUserNonProfile.obs;
  String name = '';
  String bio = '';
  var username = ''.obs;
  String email = '';

  var getInstance = FirebaseFirestore.instance.collection('user');

// ----------------for get current app users profile detiles--------------------

  userDetiles() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> user =
          await getInstance.doc(auth.currentUser?.uid).get();
      Map<String, dynamic> userData;

      if (user.exists) {
        userData = user.data() as Map<String, dynamic>;
        username.value = await userData['username'];
        profile.value = await userData['profilePic'];
      }
    } catch (e) {
      print('error $e');
    }
  }

// ---------------------------for geting other users profile detiles------------

  var otherUserName = ''.obs;
  var otherUserbio = ''.obs;
  var otherUserUsername = ''.obs;
  var otherUserProfile = ''.obs;
  var otherUserCover = ''.obs;
  var otherUserUid = ''.obs;
  RxList follwing = [].obs;
  RxList followers = [].obs;
  otherUserDetiles(String thisUserUid) async {
    if (thisUserUid == auth.currentUser?.uid) {
      navCntrlr.index.value = 4;
    } else {
      try {
        postCntrl.otherUserDetiles(thisUserUid);
        DocumentSnapshot<Map<String, dynamic>> user =
            await getInstance.doc(thisUserUid).get();
        Map<String, dynamic> userData = {};

        if (user.exists) {
          userData = user.data() as Map<String, dynamic>;
          otherUserUsername.value = await userData['username'];
          otherUserProfile.value = await userData['profilePic'];
          otherUserName.value = await userData['name'];
          otherUserbio.value = await userData['bio'];
          otherUserCover.value = await userData['cover'];
          otherUserUid.value = await userData['uid'];
          follwing.value = await userData['Following'];
          followers.value = await userData['Followers'];

          Get.to(() => OtherUserProfile());
        } else {}
      } catch (e) {
        print('error $e');
      }
    }
  }

// ------------------------for adding profile photo-----------------------------

  addUserProfile() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'profilePic': photoUrl,
    });
  }

// ---------------------------for adding cover photo----------------------------

  addUserCover() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'cover': coverPhotoUrl,
    });
  }

// ---------------------------for users profile editing-------------------------

  profiletextEdit() async {
    _firestore.collection('user').doc(auth.currentUser!.uid).update({
      'name': namecntrl.text,
      'username': usernamecntrl.text,
      'bio': biocntrl.text,
    });
  }
// -------------------------following and followers-----------------------------

  followAndUnfollow(String currentUsrId, followUid) async {
    print('the user s curretnt id $followUid');
    try {
      DocumentSnapshot sanp =
          await _firestore.collection('user').doc(currentUsrId).get();
      List following = (sanp.data() as dynamic)['Following'];

      if (following.contains(followUid)) {
        await _firestore.collection('user').doc(followUid).update({
          'Followers': FieldValue.arrayRemove([currentUsrId])
        });
        await _firestore.collection('user').doc(currentUsrId).update({
          'Following': FieldValue.arrayRemove([followUid])
        });
      } else {
        await _firestore.collection('user').doc(followUid).update({
          'Followers': FieldValue.arrayUnion([currentUsrId])
        });
        notiCntrl.notficationAdd(followUid, "Follows you", currentUsrId, "");
        await _firestore.collection('user').doc(currentUsrId).update({
          'Following': FieldValue.arrayUnion([followUid])
        });
      }
    } catch (e) {
      print('error occur in the following $e');
    }
  }

// -----------------------follow unfollow list update---------------------------
  otherUserFollowListUpdate(String thisUserUid) async {
    try {
      postCntrl.otherUserDetiles(thisUserUid);
      DocumentSnapshot<Map<String, dynamic>> user =
          await getInstance.doc(thisUserUid).get();
      Map<String, dynamic> userData = {};

      if (user.exists) {
        userData = user.data() as Map<String, dynamic>;
        followers.value = await userData['Followers'];
        followers.refresh();
      } else {}
    } catch (e) {
      print('error $e');
    }
  }
// --------------------------for image pick from device ------------------------

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
