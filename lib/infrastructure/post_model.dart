class PostModel {
  String? photoUrl, decription, time, uid;
  List? like;
  List? comment;

  PostModel(
      {this.photoUrl,
      this.decription,
      this.time,
      this.uid,
      this.comment,
      this.like});

  Map<String, dynamic> tomap() {
    return {
      'photoUrl': photoUrl,
      'decription': decription,
      'time': time,
      'uid': uid,
      'comment': [],
      'like': []
    };
  }
}
