import 'dart:math';

import 'package:codeup/ui/forums/forums_screen.dart';
import 'package:codeup/ui/forums/viewModel/forum_view_model.dart';
import 'package:codeup/ui/post/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../services/auth_service.dart';
import '../../authentication/sign_in/sign_in_screen.dart';
import '../../common/custom_app_bar.dart';
import '../../common/custom_colors.dart';
import '../forum_list_item.dart';
import 'forum_posts_list.dart';

class ForumPageScreen extends StatefulWidget {
  ForumListItem forum;

  static const routeName = "/forumPage-screen";
  ForumPageScreen(this.forum, {Key? key}) : super(key: key);

  @override
  State<ForumPageScreen> createState() => _ForumPageScreenState();
}

class _ForumPageScreenState extends State<ForumPageScreen> {
  final background_color = CustomColors.lightGrey3;
  final Color _randomColor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
  ForumViewModel forumViewModel = ForumViewModel();
  _ForumPageScreenState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isJoined(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (() => _createPost()),
            child: Icon(Icons.add),
            backgroundColor: CustomColors.mainYellow,
          ),
          backgroundColor: background_color,
          //drawer: Menu(),
          body: CustomScrollView(
            slivers: [
              CustomAppBar(widget.forum.forum.title, false),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(color: background_color),
                    //height: MediaQuery.of(context).size.height * 1/ 8,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 10, left: 10),
                                  child: Icon(
                                    widget.forum.icon,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                    child: Text(
                                  widget.forum.forum.description,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                              ],
                            ),
                            if(snapshot.data != null && snapshot.data == true)
                            TextButton(
                                onPressed: () => unjoinForum(context),
                                child: const Text(
                                  "Unjoin forum",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        color: _isAColor(widget.forum.forum.color)
                            ? colorFromHex((widget.forum.forum.color))
                            : _randomColor,
                      ),
                    ),
                  ),
                  ForumPostsList(widget.forum.forum.id)
                ]),
              ),
            ],
          ),
        );
      }
    );
  }

  bool _isAColor(String value) {
    return value.length == 8;
  }

  void _createPost() async {
    if (AuthService.currentUser != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return CreatePostScreen(widget.forum.forum.id);
      }));

      //Navigator.of(context).pushNamed("/createPost-screen");
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return SignInScreen(true);
      }));
    }
  }

  Future<bool> _isJoined() async {
    final response = await forumViewModel.fetchForumsOfUser();
    final forumsIdOfUser = response.map((forumListItem) => forumListItem.forum.id).toList();
   if(forumsIdOfUser.contains(widget.forum.forum.id)) widget.forum.isJoined = true;
    return forumsIdOfUser.contains(widget.forum.forum.id);
  }

  unjoinForum(BuildContext context) async {
    if (widget.forum.isJoined) {
      await forumViewModel.unjoinForum(
          AuthService.currentUser!.user.id, widget.forum.forum.id);
      setState(() {
        widget.forum.isJoined = false;
      });
      Navigator.of(context).pushNamed(ForumsScreen.routeName);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ForumPageScreen(widget.forum)));
    }
  }
}
