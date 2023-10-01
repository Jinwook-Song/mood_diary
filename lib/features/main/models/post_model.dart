class PostModel {
  final String id;
  final String creatorUid;
  final String creator;
  final String diary;
  final String mood;
  final int createdAt;

  PostModel({
    required this.id,
    required this.creatorUid,
    required this.creator,
    required this.diary,
    required this.createdAt,
    required this.mood,
  });

  PostModel.fromJson({
    required Map<String, dynamic> json,
    required String postId,
  })  : id = postId,
        creatorUid = json['creatorUid'],
        creator = json['creator'],
        diary = json['diary'],
        createdAt = json['createdAt'],
        mood = json['mood'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorUid': creatorUid,
      'creator': creator,
      'diary': diary,
      'createdAt': createdAt,
      'mood': mood,
    };
  }
}
