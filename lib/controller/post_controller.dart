import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/nav_controller.dart';
import 'package:fusion_sync/controller/notification_controller.dart';
import 'package:fusion_sync/model/post_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostController extends GetxController {
  final navCntrlr = Get.put(NavController());
  final notiCntrl = Get.put(NotificationController());
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
  var getInstance = FirebaseFirestore.instance.collection('userPosts');

// --------------------------for getting all users Deteiles---------------------

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

// -----------------------for getting all users posts---------------------------

  RxList<DocumentSnapshot> allPost = <DocumentSnapshot>[].obs;

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

// ---------------------for getting this users posts----------------------------

  RxList<DocumentSnapshot> thisUserPost = <DocumentSnapshot>[].obs;

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

// ---------------------fot getting posts of the Other user we want-------------

  RxList<DocumentSnapshot> otherUserPost = <DocumentSnapshot>[].obs;

  otherUserDetiles(String thisUserId) async {
    otherUserPost.value.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userPosts')
        .doc(thisUserId)
        .collection('thisUser')
        .orderBy("time", descending: false)
        .get();
    otherUserPost.value = querySnapshot.docs;
    otherUserPost.refresh();
  }

// --------------------------for adding posts-----------------------------------

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
      navCntrlr.index.value = 0;
      dicriptionCntrl.clear();
      imgFile.value = '';
      loadPost.value = false;
    } else {
      Get.snackbar("error", 'please select the image');
      loadPost.value = false;
    }
  }

// -------------------------for like the post-----------------------------------

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
        notiCntrl.notficationAdd(
            postUserId, "Liked your pic", thisUserId, postId);
      }
    } catch (e) {
      Get.snackbar("error", '$e');
    }
  }

  // ---------------------------for updating the like-----------------------------

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

// ---------------------- for adding comments-----------------------------------

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

      notiCntrl.notficationAdd(
          postUserId, "commented on your pic", thisUserId, postId);
    } catch (e) {
      Get.snackbar("error", "$e");
    }
  }

// -------------------for getting comments of each users------------------------

  RxList<DocumentSnapshot> allCommentList = <DocumentSnapshot>[].obs;

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

// -------------------------------- for delete the post-------------------------
  deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userPosts')
          .doc(auth.currentUser?.uid)
          .collection('thisUser')
          .doc(postId)
          .collection('comment')
          .get()
          .then((snap) {
        for (var ds in snap.docs) {
          ds.reference.delete();
        }
      });
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
// -------------------------comment delete--------------------------------------

  deletePostComment(String postId, commentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('userPosts')
          .doc(auth.currentUser?.uid)
          .collection('thisUser')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();
      thisUserDetiles();
      allUsresPostDetiles();
    } catch (e) {
      print('$e');
    }
  }

// ------------------------for image saving-------------------------------------
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

// -------------------------for change format into time ago---------------------

  String dateTimeFormatChange(DateTime timeStamp) {
    return timeago.format(timeStamp, locale: 'en_long');
  }
}
