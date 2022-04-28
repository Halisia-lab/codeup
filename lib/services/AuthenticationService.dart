import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Person.dart';
import '../models/Question.dart';


class AuthenticationService {
  final _baseUrl = "http://0.0.0.0:3000/";

  Future<Person> login(String username, String password) async {
    try{
      final response = await http.post(
        Uri.parse(_baseUrl + "login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      var json = jsonDecode(response.body);

      if (response.statusCode != 200) {
        String jsonError = json["error"];
        throw Exception(jsonError);
      }
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      //var jsonPerson = json["body"]["data"][0];
      return Person.fromJson(json);
    }catch(err){
      throw Exception(err);
    } 
  }
}