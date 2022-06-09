import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:http/http.dart';

import '../entities/person.dart';
import '../entities/post.dart';
import 'secure_storage.dart';

class PostService {
  static String apiUrl = "http://" + (dotenv.env.keys.contains("HOST") ? dotenv.env["HOST"]! : "localhost") + ":" + (dotenv.env.keys.contains("SERVER_PORT") ? dotenv.env["SERVER_PORT"]! : "8080") + "/";
  PostService();

  Future<http.Response> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl + "posts/all/limit/20/offset/0"));
    
    return response;
  }

  Future<http.Response> addPost(
      Post post, Person user) async {
        String token = "";
        token = await SecureStorageService.getInstance().get("token").then((value) => token = value.toString());
    final response =  http.post(
      Uri.parse(apiUrl + 'posts/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': token,

      },
      body: jsonEncode({
        'title': post.title,
        'content': post.content,
        'forumId': post.forumId,
        'code': post.code,
        'userId':user.user.id
      }),
    );
    return response;
  }

  
}