import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/ui/forums/viewModel/forum_view_model.dart';
import 'package:flutter/material.dart';

import '../common/test_data.dart';
import 'forum_list_item.dart';

/* HomeViewModel homeViewModel = HomeViewModel();
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
    ); */

class ForumList extends StatelessWidget {
  ForumList({Key? key}) : super(key: key);

  ForumViewModel forumViewModel = ForumViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: forumViewModel.fetchForums(), builder: (BuildContext context, AsyncSnapshot<List<ForumListItem>> snapshot) {
      return snapshot.data != null ?
      ListView(children: [
        for (ForumListItem forum in snapshot.data as List<ForumListItem>) forum
      ],) : Text("Loading...");
    })
  /* Padding(
        padding: const EdgeInsets.only(top: 8, left: 10.0),
        child: 
          ListView(
          padding: const EdgeInsets.all(2),
          children: <Widget>[
            for(ForumListItem forumListItem in TestData.forums)
                ListTile(leading: Icon(Icons.javascript, size: 45,color: CustomColors.mainYellow),title: ForumListItem(forumListItem.name, forumListItem.icon, forumListItem.isJoined, forumListItem.number), onTap: () => print("open forum"), style: ListTileStyle.list,)
              
            
          ],
        )) */;
  }
}
