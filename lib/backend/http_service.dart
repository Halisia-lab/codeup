/* import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../entities/user.dart';

class HttpService {
  final String usersURL = "http://54.237.177.133:8080/users";

  /* Future<List<User>> getUsers() async {
    Response res = await get(Uri.parse(usersURL));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      print(obj['user'][0]['symbol']);
      List<User> users = [];

      for (int i = 0; i < obj['user'].length; i++) {
        User user = User(
            obj['user'][i]['id'],
            obj['user'][i]['email'],
            obj['user'][i]['password'],
            obj['user'][i]['firstname'],
            obj['user'][i]['lastname']);
        users.add(user);
      }

      return users;
    } else {
      throw "Unable to retrieve user data.";
    }
  } */

  /* Future<http.Response> createUser(String email, String password, String firstname, String lastname) {
  return http.post(
    Uri.parse('http://54.237.177.133:8080/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,

    }),
  ); */

  Future<http.Response> login(String email, String password) async {
    print(email);
    return http.post(
      Uri.parse('http://54.237.177.133:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }

  Future<User> createUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://54.237.177.133:8080/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password':password
    }),
  );

  if (response.statusCode == 201) {
    
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to log user.');
  }
}
}
 */