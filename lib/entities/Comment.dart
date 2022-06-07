class Comment {
  final int id;
  final String content;
  final String commentParentId;
  final int userId;
  final String code;
  final int postId;

  const Comment(this.id,  this.content, this.commentParentId,  this.userId,  this.code,  this.postId);
 
factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['id'],
      json['content'],
      json['commentParentIde'],
      json['userId'],
      json['code'],
      json['postId'],
    );
  }

  @override
  String toString() {
    return "{id: $id, content: $content, commentParentId: $commentParentId, userId: $userId, code: $code, postId: $postId}";
  }
}