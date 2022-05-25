class Post {
  final int id;
  final String title;
  final String content;
  final String code;
  final int forumId;
  final int userId;

  const Post(this.id, this.title, this.content, this.code, this.forumId, this.userId);

factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['id'],
      json['title'],
      json['content'],
      json['code'],
      json['forumId'],
      json['userId'],
    );
  }
 @override
  String toString() {
    return "{id: $id, title: $title, content: $content, code: $code, forum_id: $forumId, user_id: $userId}";
  }
}