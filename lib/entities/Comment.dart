class Comment {
  final int id;
  final String content;
  String? commentParentId;
  final int userId;
  final String code;
  final int postId;

  Comment({required this.id, required this.content, this.commentParentId = "-1", required this.userId, required this.code, required this.postId});
 
factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      commentParentId: json['commentParentId'],
      userId: json['userId'],
      code: json['code'],
      postId: json['postId'],
    );
  }

  @override
  String toString() {
    return "{id: $id, content: $content, commentParentId: $commentParentId, userId: $userId, code: $code, postId: $postId}";
  }
}