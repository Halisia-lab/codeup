import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../post/post_box.dart';
import 'home_top.dart';
import 'viewModel/home_view_model.dart';

//TODO consumer de CustomAppBar

class PostBoxList extends StatefulWidget {
  final CustomAppBar homeTop;
  PostBoxList(this.homeTop);

  @override
  _PostBoxListState createState() => _PostBoxListState();

  HomeViewModel homeViewModel = HomeViewModel();
}


class _PostBoxListState extends State<PostBoxList> {
  HomeViewModel homeViewModel = HomeViewModel();
  bool isChecked = false;
  late Future<List<PostBox>> posts;
   Color getColor(Set<MaterialState> states) {
    return CustomColors.mainYellow;
  }
  @override
  Widget build(BuildContext context) {
    if(isChecked) {
      setState(() {
        posts =  homeViewModel.fetchWantedPosts("php") ;
      });
    } else {
      setState(() {
        posts = homeViewModel.fetchPosts();
      });
    }
    
    return ChangeNotifierProvider(
      create: (context) => widget.homeTop,
      child: FutureBuilder(
        future: homeViewModel.fetchPosts(),//posts,
        builder: (BuildContext context, AsyncSnapshot<List<PostBox>> snapshot) {
          return snapshot.data != null
              ? Consumer<CustomAppBar>(
                builder: (context, appBar, child) {
                  return ListView(
                    
                      children: [
                        for (PostBox post in snapshot.data as List<PostBox>) 
                        (post.post.title.toLowerCase().contains(appBar.valueSearch.toLowerCase()) || post.post.content.toLowerCase().contains(appBar.valueSearch.toLowerCase())) ? post : Container()
                       
                      ],
                    );
                }
              )
              : Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: CustomColors.mainYellow,
            )
          );
        },
      ),
    );
  }

  
}
