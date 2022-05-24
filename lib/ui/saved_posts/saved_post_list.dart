import 'package:flutter/material.dart';

import '../../entities/person.dart';
import '../../services/auth_service.dart';
import '../common/test_data.dart';
import '../post/post_box.dart';

class SavedPostList extends StatefulWidget {
  static List<PostBox> savedPosts = [];
  SavedPostList();
  @override
  _SavedPostListState createState() => _SavedPostListState();
}

class _SavedPostListState extends State<SavedPostList> {
  @override
  Widget build(BuildContext context) {
    Person? currentUser = AuthService.currentUser;
    List<PostBox> posts = TestData.posts;
    for (PostBox post in posts) {
      if (post.isSaved) SavedPostList.savedPosts.add(post);
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 20.0, bottom: 0.0),
        child: SingleChildScrollView(
            child: Column(
          children: [for (PostBox post in SavedPostList.savedPosts) post],
        )),
      ),
    );
  }
}
