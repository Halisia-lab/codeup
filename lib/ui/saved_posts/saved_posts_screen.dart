import 'package:codeup/ui/common/custom_app_bar.dart';
import 'package:codeup/ui/saved_posts/saved_post_list.dart';
import 'package:flutter/material.dart';

import '../common/custom_colors.dart';
import '../home/home_post_list.dart';
import '../menu/home_menu.dart';

class SavedPostsScreen extends StatefulWidget {
  static const routeName = "/savedPosts-screen";
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  final background_color = CustomColors.lightGrey3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      drawer: HomeMenu(),
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Saved Posts", true),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 4 / 5,
                child: SavedPostList(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
