import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/notification_controller.dart';
import 'package:fusion_sync/controller/post_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/notification/widgets/notification_listitem_widget.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final notiCntrl = Get.put(NotificationController());
  final postCntrl = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Notifications", style: mainTextHeads),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await notiCntrl.getNotificationList();
        },
        child: Obx(
          () => ListView.builder(
              itemCount: notiCntrl.notificationList.length,
              itemBuilder: (context, index) {
                var profile = '';
                var username = '';
                var content = '';
                var time = '';
                try {
                  var notification = notiCntrl.notificationList[index];
                  content = notification['content'];
                  time = notiCntrl
                      .dateTimeFormatChange(notification['time'].toDate());
                  for (var element in postCntrl.allUserDetiles) {
                    if (element['uid'] == notification['otherUserId']) {
                      username = element['username'];
                      profile = element['profilePic'];
                    }
                  }
                } catch (e) {
                  print(
                      "the erorr in this notification is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$e");
                }
                return NotificationItem(
                  profile: profile,
                  content: content,
                  username: username,
                  time: time,
                );
              }),
        ),
      ),
    );
  }
}
