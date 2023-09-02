class MessegeModel {
  String? senderId, receiverId, messege;
  DateTime? time;

  MessegeModel({this.messege, this.receiverId, this.senderId, this.time});

  Map<String, dynamic> toMap() {
    return {
      "SenderId": senderId,
      "receiverId": receiverId,
      "Messege": messege,
      "Time": time
    };
  }
}
