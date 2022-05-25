import 'dart:convert';
import 'package:http/http.dart' as http;

import 'secure_storage.dart';

class UserForumRelationService {
  String apiUrl = "http://10.0.2.2:8080/user-forum-relation";
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