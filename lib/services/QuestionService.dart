import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Question.dart';


class QuestionService {
  final _baseUrl = "http://0.0.0.0:3000/";

  Future<List<Question>> getQuestions() async{
    try{
      final response = await http.get(
        Uri.parse(_baseUrl + "getQuestions"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        
      );
      var json = jsonDecode(response.body);
      if (response.statusCode != 200) {
        dynamic jsonError = json["error"];
        throw Exception(jsonError);
      }
      //List<dynamic> jsonArraySection= json["body"]["data"];
      List<Question> questions =
          json.map((dynamic it) => Question.fromJson(it)).toList();
      return questions;
    }catch(err){
      throw Exception(err);
    } 
  }

  // Future<List<User>> getUsersByStatus(String status) async {
  //   try{
  //     final response = await http.get(
  //       Uri.parse(_baseUrl + "getIndividualsByStatus?status=" + status),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     var json = jsonDecode(response.body);
  //     if (response.statusCode != 200) {
  //       dynamic jsonError = json["error"];
  //       throw Exception(jsonError);
  //     }
  //     List<dynamic> jsonArrayUser = json["body"]["data"];
  //     List<User> users =
  //         jsonArrayUser.map((dynamic it) => User.fromJson(it)).toList();
  //     return users;
  //   }catch(err){
  //     throw Exception(err);
  //   } 
  // }

  // Future<void> setUserStatusAdminByIdUser(int idUserToPromote, int idUserWhoPromotes) async{
  //   try{
  //     final response = await http.put(
  //       Uri.parse(_baseUrl + "setUserStatusAdminByIdUser"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, int>{
  //         'idUserToPromote': idUserToPromote,
  //         'idUserWhoPromotes': idUserWhoPromotes,
  //       }),
  //     );
  //     var json = jsonDecode(response.body);
  //     if (response.statusCode != 200) {
  //       dynamic jsonError = json["error"];
  //       throw Exception(jsonError);
  //     }
  //   }catch(err){
  //     throw Exception(err);
  //   } 
  // }
  // Future<void> createSection(String title, String description) async {
  //   try{
  //     final response = await http.post(
  //       Uri.parse(_baseUrl + "createSection"),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'title': title,
  //         'description': description,
  //       }),
  //     );
  //     var json = jsonDecode(response.body);

  //     if (response.statusCode != 200) {
  //       String jsonError = json["error"];
  //       throw Exception(jsonError);
  //     }
  //   }catch(err){
  //     throw Exception(err);
  //   } 
  // }

}
