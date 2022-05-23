import 'package:codeup/ui/home/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../post/post_box.dart';

class PostBoxList extends StatefulWidget {
  const PostBoxList({Key? key}) : super(key: key);

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
            : Text("Loading...");
      },
    );
  }

  
}
