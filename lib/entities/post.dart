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
    return "{id: ${this.id}, title: ${this.title}, content: ${this.content}, code: ${this.code}, forum_id: ${this.forumId}, user_id: ${this.userId}}";
  }
}