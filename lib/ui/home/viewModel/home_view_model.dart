import 'dart:convert';
import 'dart:math';

import 'package:codeup/utils/date_helper.dart';
import 'package:flutter/material.dart';

import '../../../entities/post.dart';
import '../../../services/post_service.dart';
import '../../common/language_enum.dart';
import '../../post/post_box.dart';
import '../../post/viewModel/post_view_model.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel();
  PostViewModel postViewModel = PostViewModel();
  PostService postService = PostService();
  List<Post> loggedUserPosts = [];

  Future<List<PostBox>> fetchPosts() async {
    List<PostBox> allPosts = [];
    await postService.fetchPosts().then((data) async {
      for (dynamic element in jsonDecode(data.body)) {
        Post post = Post.fromJson(element);
        PostBox postBoxWidget = PostBox(
            post,
            const [LanguageValue.C, LanguageValue.JAVA],
            post.userId,
            false,
            await postViewModel.getCommiter(post),
            true);
        allPosts.add(postBoxWidget);
      }
    });
    return allPosts;
  }

  Future<List<PostBox>> fetchWantedPosts(String searchBarValue) async {
    List<PostBox> allPosts = [];
    await postService.fetchPosts().then((data) async {
        for (dynamic element in jsonDecode(data.body)) {
          Post post = Post.fromJson(element);
          PostBox postBoxWidget = PostBox(
              post,
              const [LanguageValue.C, LanguageValue.JAVA],
              post.userId,
              false,
              await postViewModel.getCommiter(post),
              true);

          if (post.title.toLowerCase().contains(searchBarValue.toLowerCase())) {
            allPosts.add(postBoxWidget);
          }
        }
    });
    return allPosts;
  }
}
