import 'dart:convert';
import 'package:codeup/services/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../entities/person.dart';
import '../ui/authentication/viewModel/sign_in_fields_view_model.dart';
import '../entities/user.dart';
import '../ui/common/test_data.dart';

class AuthService {
  static String apiUrl = "http://" + (dotenv.env.keys.contains("HOST") ? dotenv.env["HOST"]! : "localhost") + ":" + (dotenv.env.keys.contains("SERVER_PORT") ? dotenv.env["SERVER_PORT"]! : "8080") + "/";
  //static String apiUrl = "http://" + host + ":8080/";
  SignInFieldsViewModel? signInFieldsVm;
  static Person? currentUser;

  AuthService({this.signInFieldsVm});

  

  void getLoggedUser(User userFields) async {
    List<User> users = [];
    final response = await http.get(Uri.parse(apiUrl + "users/users"));

    for (dynamic element in jsonDecode(response.body)) {
      User user = User.fromJson(element);
      users.add(user);
    }

    User loggedUser =
        users.firstWhere((user) => user.username == userFields.username);
    currentUser = Person(loggedUser, TestData.photos[1]);
  }

  Future<http.Response> getUsers() async {
    List<User> users = [];
    final response = await http.get(Uri.parse(apiUrl + "users/users"));

    for (dynamic element in jsonDecode(response.body)) {
      User user = User.fromJson(element);
      users.add(user);
    }
    return response;
  }

  Future<User> getUserById(int id) async {
    User user;
    final response =
        await http.get(Uri.parse(apiUrl + "users/" + id.toString()));
    user = User.fromJson(jsonDecode(response.body));

    return user;
  }

  Future<http.Response> logIn(
      SignInFieldsViewModel signInFieldsVm, User user) async {
    var response =  await http.post(
      Uri.parse(apiUrl + "login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': user.password
      }),
    );

    return response;
    
   
  }

  Future<http.Response> register(
      SignInFieldsViewModel signInFieldsVm, User user) async {
    return await http.post(
      Uri.parse(apiUrl + 'users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': user.password,
        'email': user.email,
        'firstname': user.firstname,
        'lastname': user.lastname
      }),
    );
  }

  static void setCurrentUser(Person? user) {
    currentUser = user;
  }

}
