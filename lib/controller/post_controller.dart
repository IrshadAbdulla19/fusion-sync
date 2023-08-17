import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/model/post_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController dicriptionCntrl = TextEditingController();
  TextEditingController commentCntrl = TextEditingController();

  Uint8List? _imgage;
  var load = false.obs;
  var loadPost = false.obs;
  var imgFile = ''.obs;
  String? img;
  DateTime? time;
  String photoUrl = '';
  RxList<DocumentSnapshot> allPost = <DocumentSnapshot>[].obs;
  RxList<DocumentSnapshot> allUserDetiles = <DocumentSnapshot>[].obs;
  RxList<DocumentSnapshot> allCommentList = <DocumentSnapshot>[].obs;
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

  postCommentDetiles(String postUserId, postId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> getComments = await FirebaseFirestore
          .instance
          .collection('userPosts')
          .doc(postUserId)
          .collection('thisUser')
          .doc(postId)
          .collection('comments')
          .get();
      allCommentList.value = getComments.docs;
    } catch (e) {
      print('the error in post comment is $e');
    }
  }

  allUsresPostDetiles() async {
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
      allPost.value.addAll(querySnapshot.docs);
      allPost.refresh();
    }
  }

  thisUserDetiles() async {
    thisUserPost.value.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userPosts')
        .doc(auth.currentUser?.uid)
        .collection('thisUser')
        .get();
    thisUserPost.value = querySnapshot.docs;
    thisUserPost.refresh();
  }

  likeUserDetiles(String postUserId, postId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userPosts')
        .doc(postUserId)
        .collection('thisUser')
        .get();
    List<DocumentSnapshot> allposts = querySnapshot.docs;
    for (var i = 0; i < allposts.length; i++) {
      var userpost = allposts[i];
      if (postId == userpost['postId']) {
        int indx = 0;
        for (var element in allPost) {
          if (element['postId'] == postId) {
            allPost[indx] = userpost;
            allPost.refresh();
          }
          indx++;
        }
      }
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
        thisUserDetiles();
        allUsresPostDetiles();
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

  postComments(String postId, postUserId, thisUserId) async {
    try {
      String id = const Uuid().v1();
      await firestore
          .collection('userPosts')
          .doc(postUserId)
          .collection('thisUser')
          .doc(postId)
          .collection('comments')
          .doc(id)
          .set({
        'commentId': id,
        'commentedUSerId': thisUserId,
        'comment': commentCntrl.text,
        'time': DateTime.now()
      });
      commentCntrl.clear();
    } catch (e) {
      Get.snackbar("error", "$e");
    }
  }

  deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userPosts')
          .doc(auth.currentUser?.uid)
          .collection('thisUser')
          .doc(postId)
          .delete();
      thisUserDetiles();
      allUsresPostDetiles();
    } catch (e) {
      print('$e');
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

  String dateTimeFormatChange(DateTime timeStamp) {
    return timeago.format(timeStamp, locale: 'en_long');
  }
}
