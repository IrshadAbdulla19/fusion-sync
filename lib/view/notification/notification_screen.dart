import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/notification/widgets/notification_listitem_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Notifications", style: mainTextHeads),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) => NotificationItem(),
      ),
    );
  }
}
