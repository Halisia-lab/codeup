import 'dart:convert';
import 'dart:math';

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
  List<PostBox> allPosts = [];
  List<PostBox> researchedPosts = [];
  List<Post> loggedUserPosts = [];
  
  final _random = new Random();

  Future<List<PostBox>> fetchPosts(String researchValue) async {
    await postService.fetchPosts().then((data) async {
      for (dynamic element in jsonDecode(data.body)) {
        Post post = Post.fromJson(element);
        PostBox postBoxWidget = PostBox(
            post,
            const [LanguageValue.C, LanguageValue.JAVA],
            post.userId,
            true,
            await postViewModel.getCommiter(post));
        if(researchValue.length > 3 && post.title.contains(researchValue)) researchedPosts.add(postBoxWidget);
        allPosts.add(postBoxWidget);
      }
    });
    return researchValue.length > 3 ? allPosts : researchedPosts;
  }

}
