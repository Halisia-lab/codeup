import 'dart:math';

import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/ui/forums/forum_page/forum_page_screen.dart';
import 'package:codeup/ui/forums/viewModel/forum_view_model.dart';
import 'package:flutter/material.dart';

import '../../entities/forum.dart';
import '../../services/auth_service.dart';
import '../authentication/sign_in/sign_in_screen.dart';
import '../common/custom_button.dart';

class ForumListItem extends StatefulWidget {
  Forum forum;
  final String name;
  final IconData icon;
  bool isJoined;
  int number;
  ForumListItem(this.forum, this.name, this.icon, this.isJoined, this.number,
      {Key? key})
      : super(key: key);

  @override
  State<ForumListItem> createState() =>
      _ForumListItemState(forum, name, icon, isJoined, number);
}

class _ForumListItemState extends State<ForumListItem> {
  _ForumListItemState(
      this.forum, this.name, this.icon, this.isJoined, this.number);
  Forum forum;
  final String name;
  final IconData icon;
  bool isJoined;
  int number;
  ForumViewModel forumViewModel = ForumViewModel();

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: _isJoined(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return ListTile(
          title: Container(
            margin: const EdgeInsets.only(
              bottom: 5,
            ),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      forum.title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  snapshot.data != null ?
                  (!snapshot.data!
                      ? CustomButton(
                          CustomColors.mainYellow, "Join", () => joinForum())
                      : TextButton(
                          onPressed: () => unjoinForum(),
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Joined",
                              style: TextStyle(
                                  color: CustomColors.mainYellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )) ) : const SizedBox(height: 48,) 
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
          onTap: () => _getForumPage(context, widget),
        );
      }
    );
  }

  joinForum() {
    if (AuthService.currentUser != null) {
      setState(() {
        forumViewModel.joinForum(AuthService.currentUser!.user.id, widget.forum.id);
        isJoined = true;
      });
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return SignInScreen(true);
      }));
    }
  }

  unjoinForum() {
    setState(() {
        forumViewModel.unjoinForum(AuthService.currentUser!.user.id, widget.forum.id);
        isJoined = false;
      });
  }

  Future<bool> _isJoined() async {
    final response = await forumViewModel.fetchForumsOfUser();
    final forumsIdOfUser = response.map((forumListItem) => forumListItem.forum.id).toList();
   
    return forumsIdOfUser.contains(widget.forum.id);
  }

  _getForumPage(BuildContext context, ForumListItem forumListItem) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ForumPageScreen(forumListItem)));
  }

  bool operator ==(dynamic other) =>
      other != null &&
      other is ForumListItem &&
      this.forum.title == other.forum.title;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

/* CustomButton(CustomColors.mainYellow, "Join", () => _joinForum() */