import 'dart:convert';
import 'package:http/http.dart' as http;

import '../ui/authentication/viewModel/sign_in_fields_view_model.dart';

import '../entities/user.dart';

class AuthService {
  static String apiUrl = "http://10.0.2.2:8080/";
  SignInFieldsViewModel? signInFieldsVm;
  static User? currentUser = null;

  AuthService({this.signInFieldsVm});

  void getLogedUser(User userFields) async {
    List<User> users = [];
    final response = await http.get(Uri.parse(apiUrl + "users/users"));

    for (dynamic element in jsonDecode(response.body)) {
      User user = User.fromJson(element);
      users.add(user);
    }

    User loggedUser =
        users.firstWhere((user) => user.username == userFields.username);
    currentUser = loggedUser;
    // return users;
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
    final response = await http.get(Uri.parse(apiUrl + "users/users/" + id.toString()));
      user = User.fromJson(jsonDecode(response.body));
    
    return user;
  }

  Future<http.Response> logIn(
      SignInFieldsViewModel signInFieldsVm, User user) async {
    getLogedUser(user);
    return await http.post(
      Uri.parse(apiUrl + 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': user.password
      }),
    );
  }

  static void setCurrentUser(User? user) {
    currentUser = user;
    print(currentUser);
  }
}
