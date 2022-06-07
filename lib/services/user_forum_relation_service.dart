import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import 'secure_storage.dart';

class UserForumRelationService {
  static String apiUrl = "http://" + (dotenv.env.keys.contains("HOST") ? dotenv.env["HOST"]! : "localhost") + ":" + (dotenv.env.keys.contains("SERVER_PORT") ? dotenv.env["SERVER_PORT"]! : "8080") + "/user-forum-relation";
  UserForumRelationService();

  Future<http.Response> fetchForums() async {
    final response = await http.get(Uri.parse(apiUrl + "/all-by-logged-user"));
    return response;
  }

  Future<http.Response> addRelation(
      int userId, int forumId) async {
        final String? userAuthToken = await SecureStorageService.getInstance().get("jwtToken");
    return await http.post(
      Uri.parse(apiUrl + '/add/forums/' + forumId.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $userAuthToken'
      },
      body: jsonEncode({
        'userId': userId,
        'forumId': forumId,
      }),
    );
  }

  Future<http.Response> deleteRelation(
    int forumId) async {
      return await http.delete(
        Uri.parse(apiUrl + '/delete/forum/' + forumId.toString()),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    }
}