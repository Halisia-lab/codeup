import 'Person.dart';

class Comment {
  final String id;
  final Person commiter;
  final bool state;
  final int rating;
  final String urlFile;
  final List<Comment> responses;
  final DateTime date;

  Comment({required this.id, required this.commiter, required this.state,required this.rating, required this.urlFile, required this.responses, required this.date});

  factory Comment.fromJson(Map<String, dynamic> json){
    String id = json['id'];
    Person commiter = json['commiter'];
    bool state = json['state'];
    int rating = json['rating'];
    String urlFile = json['urlFile'];
    List<Comment> responses = json['responses'];
    DateTime date = json['date'];

    return Comment(
      id: id,
      commiter: commiter,
      state: state,
      rating: rating,
      urlFile: urlFile,
      responses: responses,
      date: date
    );
  }

  
  String toString() {
    return "Comment(id: $id, commiter: $commiter, state: $state, rating: $rating, urlFile: $urlFile, responses: $responses, date: $date)";
  }
}
