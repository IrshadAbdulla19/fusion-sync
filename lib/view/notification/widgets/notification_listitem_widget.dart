import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem(
      {super.key,
      required this.content,
      required this.profile,
      required this.username,
      required this.time});

  String profile;
  String username;
  String time;
  String content;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kBlackColor,
        backgroundImage:
            NetworkImage(profile == '' ? nonUserNonProfile : profile),
        radius: 23,
      ),
      title: Text(
        "$username $content",
        style: normalTextStyleBlack,
      ),
      trailing: Text(
        time,
        style: normalTextStyleBlack,
      ),
    );
  }
}
