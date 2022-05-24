class Comment {
  final int id;
  final String content;
  String? commentParentId;
  final String userId;
  final String code;
  final String postId;

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
    return "{id: ${this.id}, content: ${this.content}, commentParentId: ${this.commentParentId}, userId: ${this.userId}, code: ${this.code}, postId: ${this.postId}}";
  }
}