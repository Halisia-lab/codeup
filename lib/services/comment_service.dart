import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../entities/comment.dart';
import '../entities/person.dart';
import '../entities/post.dart';

class CommentService {
  static String apiUrl = "http://" + (dotenv.env.keys.contains("HOST") ? dotenv.env["HOST"]! : "localhost") + ":" + (dotenv.env.keys.contains("SERVER_PORT") ? dotenv.env["SERVER_PORT"]! : "8080") + "/comments";
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