import 'dart:convert';
import 'dart:math';

import 'package:codeup/services/comment_service.dart';
import 'package:codeup/ui/comment/comment_list_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../entities/comment.dart';
import '../../../entities/person.dart';
import '../../../entities/post.dart';
import '../../../entities/user.dart';
import '../../../services/auth_service.dart';
import '../../common/test_data.dart';

class CommentViewModel with ChangeNotifier {
  CommentService commentService = CommentService();
  AuthService authService = AuthService();
  User? commiter = null;
  final _random = new Random();
  List<CommentListItem> allComments = [];

  Future<Person> getCommiter(Comment comment) async {
    return Person(await authService.getUserById(comment.userId), TestData.photos[randomNumber(0, 3)]);
  }

    
int randomNumber(int min, int max) => min + _random.nextInt(max - min);


  Future<List<CommentListItem>> fetchComments(int postId) async {
    await commentService.fetchCommentsOfPost(postId).then((data) async {
      
      for (dynamic element in jsonDecode(data.body)) {
       print(jsonDecode(data.body));
        Comment comment = Comment.fromJson(element);
        CommentListItem commentListItem = CommentListItem(
            comment,
            await getCommiter(comment), DateTime.now().toString());
        allComments.add(commentListItem);
      }
    });
    return allComments;
  }

  Future<Comment?> insertComment(Comment comment, Person user, Post post) async {
    
    final Response response = await commentService.addComment(comment, user, post);
    print(response.request);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return comment;
    } else {
      print(response.body);
      return null;
    }
  }

  Future<String> getCommentCount(Post post) async {
    final response =  await commentService.getCommentsCount(post.id);
    return "1";
  }

}

