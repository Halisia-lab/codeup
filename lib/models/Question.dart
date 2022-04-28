import 'Comment.dart';

class Question {
  final String id;
  final List<Comment> comments; // max 1 -> top response


  Question({required this.id, required this.comments});

  factory Question.fromJson(Map<String, dynamic> json){
    String id = json['id'];
    List<Comment> comments = json['comments'];
    //String srcicon = json['srcicon'] != null ? json['srcicon'] : "";
    
    return Question(
      id: id,
      comments: comments,
    );
  }

  
  String toString() {
    return "Question(id: $id, comments: $comments)";
  }
}
