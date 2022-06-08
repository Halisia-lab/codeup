import 'package:flutter/material.dart';

import '../../common/custom_colors.dart';
import '../../post/post_box.dart';
import '../viewModel/forum_view_model.dart';

class ForumPostsList extends StatelessWidget {
  final int id;
   ForumPostsList(this.id);

  ForumViewModel forumViewModel = ForumViewModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: forumViewModel.fetchForumPosts(id),
      builder: (BuildContext context, AsyncSnapshot<List<PostBox>> snapshot) {
        return snapshot.data != null
            ? Column(
                children: [
                  for (PostBox post in snapshot.data as List<PostBox>) post
                ],
              )
            : Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: CustomColors.mainYellow,
          )
        );
      },
    );
  }
}