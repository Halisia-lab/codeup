class Forum {
  final int id;
  final String title;
  final String description;
  final String color;

  const Forum(this.id, this.title, this.description, this.color);

factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      json['id'],
      json['title'],
      json['description'],
      json['color'],
    );
  }
 @override
  String toString() {
    return "{id: ${this.id}, title: ${this.title}, description: ${this.description}, color: ${this.color}}";
  }
}