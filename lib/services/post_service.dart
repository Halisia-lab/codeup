import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../entities/Person.dart';
import '../entities/post.dart';

import '../entities/user.dart';
import 'secure_storage.dart';

class PostService {
  String apiUrl = "http://10.0.2.2:8080/";
  PostService();

  Future<http.Response> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl + "posts/all/limit/20/offset/0"));
    return response;
  }

  Future<http.Response> addPost(
      Post post, Person user) async {
    return await http.post(
      Uri.parse(apiUrl + 'posts/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': post.title,
        'content': post.content,
        'forumId': post.forumId,
        'code': post.code,
        'user_id':user.user.id
      }),
    );
  }

  
}