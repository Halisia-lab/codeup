import 'dart:convert';

import 'package:codeup/entities/user_forum_relation.dart';
import 'package:codeup/services/forum_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:codeup/services/user_forum_relation_service.dart';
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
  UserForumRelationService userForumRelationService = UserForumRelationService();
  PostViewModel postViewModel = PostViewModel();
  PostService postService = PostService();

  //final _random = new Random();

  Future<List<ForumListItem>> fetchForums() async {
    List<ForumListItem> allForums = [];
    await forumService.fetchForums().then((data) async {
      for (dynamic element in jsonDecode(data.body)) {
        Forum forum = Forum.fromJson(element);
        ForumListItem forumListItem =
            ForumListItem(forum, forum.title, Icons.javascript, false, 1);
        allForums.add(forumListItem);
      }
    });
    return allForums.reversed.toList();
  }

  Future<List<ForumListItem>> fetchForumsOfUser() async {
    List<ForumListItem> allForums = [];
    await userForumRelationService.fetchRelationsOfUser().then((data) async {
      for (dynamic element in jsonDecode(data.body)) {
        UserForumRelation userForumRelation = UserForumRelation.fromJson(element);
        ForumListItem forum = await fetchForumById(userForumRelation.forumId) ;
    allForums.add(forum);
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
            await postViewModel.getCommiter(post),
            true);
        if (post.forumId == id) allPosts.add(postBoxWidget);
      }
    });
    return allPosts;
  }

  Future<ForumListItem> fetchForumById(int id) async {
    final data = await forumService.fetchForumById(id);
    Forum forum = Forum.fromJson(jsonDecode(data.body));
    return ForumListItem(forum, forum.title, Icons.javascript, false, 1);
  }

  Future<ForumListItem?> joinForum(int userId, int forumId) async {
    final response = await userForumRelationService.addRelation(userId, forumId);
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return fetchForumById(forumId);
    } else {
      return null;
    }
  }
  Future<void> unjoinForum(int userId, int forumId) async {
    final response = await userForumRelationService.deleteRelation(forumId);
    print(response.statusCode);
  }
}
