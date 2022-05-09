import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/post.dart';
import '../ui/authentication/viewModel/sign_in_fields_view_model.dart';

import '../entities/user.dart';

class PostService {
  String apiUrl = "http://10.0.2.2:8080/";
  static User? currentUser = null;

  PostService();

  void getPosts() async {
    List<Post> posts = [];
    final response = await http.get(Uri.parse(apiUrl + "posts/all/limit/20/offset/0"));

    for (dynamic element in jsonDecode(response.body)) {
      Post post = Post.fromJson(element);
      posts.add(post);
    }

    print(posts);

    /* Post loggedUser =
        posts.firstWhere((user) => user.username == userFields.username);
    currentUser = loggedUser; */
  }

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
}