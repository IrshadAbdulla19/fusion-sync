import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: kBlackColor,
        radius: 23,
      ),
      title: Text(
        "Sahil Liked your photo",
        style: normalTextStyleBlack,
      ),
      trailing: Text(
        "12:30",
        style: normalTextStyleBlack,
      ),
    );
  }
}
