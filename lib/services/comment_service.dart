import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/comment.dart';
import '../entities/person.dart';
import '../entities/post.dart';

class CommentService {
  String apiUrl = "http://10.0.2.2:8080/comments";
  CommentService();

  Future<http.Response> fetchCommentsOfPost(int postId) async {
    final response = await http.get(Uri.parse(apiUrl + "/comment/post/" + postId.toString()));
    return response;
  }

  Future<http.Response> getCommentsCount(int postId) async {
    final response = await http.get(Uri.parse(apiUrl + "/comment/post/" + postId.toString() + "/count"));
    return response;
  }

  Future<http.Response> addComment(
      Comment comment, Person user, Post post) async {
    return await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'content': comment.content,
        'commentParentId': comment.commentParentId,
        'userId': user.user.id,
        'code': comment.code,
        'user_id':post.id
      }),
    );
  }
}