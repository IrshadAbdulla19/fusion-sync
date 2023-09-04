import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusion_sync/model/notification_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  notficationAdd(String thisUserId, content, otheruserId, postId) async {
    var id = const Uuid().v1();
    var time = DateTime.now();
    try {
      if (thisUserId != otheruserId) {
        NotificationModel newNotification = NotificationModel(
            thisUserId: thisUserId,
            notificationId: id,
            content: content,
            postId: postId,
            othetUserId: otheruserId,
            time: time);

        await _firestore
            .collection('notification')
            .doc(thisUserId)
            .collection('thisUserNotification')
            .doc(id)
            .set(newNotification.toMap());
      }
    } catch (e) {
      print("the erorr is $e");
    }
  }

  // ----------------------------get notification list--------------------------

  RxList notificationList = [].obs;
  getNotificationList() async {
    notificationList.clear();
    var getNoti = await _firestore
        .collection('notification')
        .doc(auth.currentUser!.uid)
        .collection('thisUserNotification')
        .orderBy("time", descending: true)
        .get();

    notificationList.value = getNoti.docs;
    notificationList.refresh();
  }

  String dateTimeFormatChange(DateTime timeStamp) {
    return timeago.format(timeStamp, locale: 'en_long');
  }
}
