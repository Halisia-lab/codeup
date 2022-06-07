import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../entities/forum.dart';
import 'secure_storage.dart';

class ForumService {
  static String apiUrl = "http://" + (dotenv.env.keys.contains("HOST") ? dotenv.env["HOST"]! : "localhost") + ":" + (dotenv.env.keys.contains("SERVER_PORT") ? dotenv.env["SERVER_PORT"]! : "8080") + "/";
  ForumService();

  Future<http.Response> fetchForums() async {
    final response = await http.get(Uri.parse(apiUrl + "forums/all/limit/20/offset/0"));
    return response;
  }

  Future<http.Response> addForum(
      Forum forum) async {
        final String? userAuthToken = await SecureStorageService.getInstance().get("jwtToken");
    return await http.post(
      Uri.parse(apiUrl + 'forums/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userAuthToken'
      },
      body: jsonEncode({
        'title': forum.title,
        'description': forum.description,
        'color': forum.color
      }),
    );
  }

  
}