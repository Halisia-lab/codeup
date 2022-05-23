import 'dart:convert';
import 'dart:math';

import 'package:codeup/services/auth_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:codeup/ui/post/post_box.dart';
import 'package:flutter/material.dart';

import '../../../entities/Person.dart';
import '../../../entities/post.dart';
import '../../../entities/user.dart';
import '../../common/test_data.dart';

class PostViewModel with ChangeNotifier {
  AuthService authService = AuthService();
  User? commiter = null;
  final _random = new Random();

  Future<Person> getCommiter(Post post) async {

    return Person(await authService.getUserById(post.userId), TestData.photos[randomNumber(0, 3)]);
  }

    
int randomNumber(int min, int max) => min + _random.nextInt(max - min);


}
