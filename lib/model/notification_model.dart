class NotificationModel {
  String? thisUserId, notificationId, content, postId, othetUserId;
  DateTime? time;

  NotificationModel(
      {this.thisUserId,
      this.notificationId,
      this.content,
      this.postId,
      this.othetUserId,
      this.time});

  Map<String, dynamic> toMap() {
    return {
      'thisUser': thisUserId,
      'notificationId': notificationId,
      'content': content,
      "postId": postId,
      'otherUserId': othetUserId,
      'time': time
    };
  }
}
