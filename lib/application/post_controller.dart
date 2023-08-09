import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/infrastructure/post_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController dicriptionCntrl = TextEditingController();
  var isAnimating = false.obs;
  Uint8List? _imgage;
  var load = false.obs;
  var loadPost = false.obs;
  var imgFile = ''.obs;
  String? img;
  DateTime? time;
  String photoUrl = '';
  RxList<DocumentSnapshot> allPost = <DocumentSnapshot>[].obs;
  RxList<DocumentSnapshot> thisUserPost = <DocumentSnapshot>[].obs;
  var getInstance = FirebaseFirestore.instance.collection('userPosts');

  getThisUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userPosts')
        .doc(auth.currentUser?.uid)
        .collection('thisUser')
        .get();

    return querySnapshot;
  }

  allUsresDetiles() async {
    allPost.value.clear();
    QuerySnapshot getusers =
        await FirebaseFirestore.instance.collection('user').get();
    List<DocumentSnapshot> posts = getusers.docs;

    for (int i = 0; i < posts.length; i++) {
      var data = posts[i];
      var uid = data['uid'];
      print(data['uid']);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userPosts')
          .doc(uid)
          .collection('thisUser')
          .get();
      List<DocumentSnapshot> allposts = querySnapshot.docs;
      for (var i = 0; i < allposts.length; i++) {
        allPost.value.add(allposts[i]);
        allPost.refresh();
      }
    }
  }

  thisUserDetiles() async {
    thisUserPost.value.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userPosts')
        .doc(auth.currentUser?.uid)
        .collection('thisUser')
        .get();
    List<DocumentSnapshot> allposts = querySnapshot.docs;
    for (var i = 0; i < allposts.length; i++) {
      thisUserPost.value.add(allposts[i]);
      var user = allposts[i];
      thisUserPost.refresh();
    }
  }

  addPost() async {
    loadPost.value = true;
    await saveImgToFireBase();

    if (photoUrl != '') {
      String id = const Uuid().v1();
      PostModel post = PostModel(
          photoUrl: photoUrl,
          uid: auth.currentUser?.uid,
          decription: dicriptionCntrl.text,
          postId: id,
          time: time,
          like: []);

      try {
        await firestore
            .collection('userPosts')
            .doc(auth.currentUser?.uid)
            .collection('thisUser')
            .doc(id)
            .set(post.tomap());
      } catch (e) {
        Get.snackbar("error", "$e");
      }
      dicriptionCntrl.clear();
      imgFile.value = '';
      loadPost.value = false;
    } else {
      Get.snackbar("error", 'please select the image');
    }
  }

  Future<void> likePost(
      String thisUserId, postUserId, postId, List likes) async {
    try {
      if (likes.contains(thisUserId)) {
        await firestore
            .collection('userPosts')
            .doc(postUserId)
            .collection('thisUser')
            .doc(postId)
            .update({
          'like': FieldValue.arrayRemove([thisUserId])
        });
      } else {
        await firestore
            .collection('userPosts')
            .doc(postUserId)
            .collection('thisUser')
            .doc(postId)
            .update({
          'like': FieldValue.arrayUnion([thisUserId])
        });
      }
    } catch (e) {
      Get.snackbar("error", '$e');
    }
  }

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
