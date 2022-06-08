import 'dart:convert';

import 'package:codeup/services/forum_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:codeup/ui/forums/forum_list_item.dart';
import 'package:flutter/material.dart';

import '../../../entities/forum.dart';
import '../../../entities/post.dart';
import '../../common/language_enum.dart';
import '../../post/post_box.dart';
import '../../post/viewModel/post_view_model.dart';

class ForumViewModel with ChangeNotifier {
  ForumViewModel();
  ForumService forumService = ForumService();
  PostViewModel postViewModel = PostViewModel();
  PostService postService = PostService();
  
  //final _random = new Random();

  Future<List<ForumListItem>> fetchForums() async {
  List<ForumListItem> allForums = [];
    await forumService.fetchForums().then((data) async {
      for (dynamic element in jsonDecode(data.body)) {
        Forum forum = Forum.fromJson(element);
        ForumListItem forumListItem = ForumListItem(
            forum,
            forum.title,
            Icons.javascript,
            false,
            1);
        allForums.add(forumListItem);
      }
    });
    return allForums;
  }

  Future<List<PostBox>> fetchForumPosts(int id) async {
    List<PostBox> allPosts = [];
    await postService.fetchPosts().then((data) async {
      for (dynamic element in jsonDecode(data.body)) {
        Post post = Post.fromJson(element);
        PostBox postBoxWidget = PostBox(
            post,
            const [LanguageValue.C, LanguageValue.JAVA],
            post.userId,
            true,
            await postViewModel.getCommiter(post), true);
          if(post.forumId == id)
        allPosts.add(postBoxWidget);
      }
    });
    return allPosts;
  }



}