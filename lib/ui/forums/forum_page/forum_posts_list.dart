import 'package:flutter/material.dart';

import '../../post/post_box.dart';
import '../viewModel/forum_view_model.dart';

class ForumPostsList extends StatelessWidget {
  final String title;
   ForumPostsList(this.title);

  ForumViewModel forumViewModel = ForumViewModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: forumViewModel.fetchForumPosts(title),
      builder: (BuildContext context, AsyncSnapshot<List<PostBox>> snapshot) {
        return snapshot.data != null
            ? Column(
                children: [
                  for (PostBox post in snapshot.data as List<PostBox>) post
                ],
              )
            : Text("Loading...");
      },
    );
  }
}