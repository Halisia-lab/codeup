import 'package:flutter/material.dart';

import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../post/post_box.dart';
import 'viewModel/home_view_model.dart';

//TODO consumer de CustomAppBar

class PostBoxList extends StatefulWidget {
  PostBoxList();

  @override
  _PostBoxListState createState() => _PostBoxListState();

  HomeViewModel homeViewModel = HomeViewModel();
}


class _PostBoxListState extends State<PostBoxList> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeViewModel.fetchPosts(),
      builder: (BuildContext context, AsyncSnapshot<List<PostBox>> snapshot) {
 /*   if(snapshot.data != null) {
          if(CustomAppBar.searchValue.length > 2) {
            for(PostBox post in snapshot.data as List<PostBox>)  posts.add(post);
          } else {
            posts = snapshot.data!;
          }
        } */
        return snapshot.data != null
            ? ListView(
                children: [
                  for (PostBox post in snapshot.data as List<PostBox>) if(post.post.title.contains(CustomAppBar.searchValue))post
                 
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
