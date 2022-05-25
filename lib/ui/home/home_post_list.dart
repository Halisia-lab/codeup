import 'package:flutter/material.dart';

import '../common/custom_colors.dart';
import '../post/post_box.dart';
import 'viewModel/home_view_model.dart';

class PostBoxList extends StatefulWidget {
  PostBoxList();

  @override
  _PostBoxListState createState() => _PostBoxListState();
}


class _PostBoxListState extends State<PostBoxList> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeViewModel.fetchPosts(),
      builder: (BuildContext context, AsyncSnapshot<List<PostBox>> snapshot) {
        return snapshot.data != null
            ? ListView(
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
