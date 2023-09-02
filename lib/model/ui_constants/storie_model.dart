class StorieModel {
  String? imgUrl, storieUserId;
  DateTime? time;

  StorieModel({this.imgUrl, this.storieUserId, this.time});
  Map<String, dynamic> toMap() {
    return {"ImageUrl": imgUrl, "StorieUserId": storieUserId, "Time": time};
  }
}
