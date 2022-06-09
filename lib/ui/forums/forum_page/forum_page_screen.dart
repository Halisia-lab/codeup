
import 'dart:math';

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
  State<ForumPageScreen> createState() => _ForumPageScreenState(forum);
}

class _ForumPageScreenState extends State<ForumPageScreen> {
  ForumListItem forum;
  final background_color = CustomColors.lightGrey3;
  final Color _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
_ForumPageScreenState(this.forum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (() => _createPost()), child: Icon(Icons.add), backgroundColor: CustomColors.mainYellow,),
      backgroundColor: background_color,
      //drawer: Menu(),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(forum.forum.title, false),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(color: background_color),
                //height: MediaQuery.of(context).size.height * 1/ 8,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(child: Row(
                    children: [
                      Icon(forum.icon, size: 80,color: Colors.white,),
                      Flexible(child: Text(forum.forum.description , style: TextStyle(color: Colors.white, fontSize: 18),)),
                    ],
                  ), color: _isAColor(forum.forum.color) ? colorFromHex((forum.forum.color)) : _randomColor,),
                ),
              ),
              ForumPostsList(forum.forum.id)
            ]),
          ),
        ],
      ),
    );
  }

  bool _isAColor(String value) {
    return value.length == 8;
  }

    
  void _createPost()async  {
    if(AuthService.currentUser != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_)  { return CreatePostScreen(forum.forum.id);}));
    
      //Navigator.of(context).pushNamed("/createPost-screen");
    } else {
       Navigator.of(context).push(MaterialPageRoute(builder: (_)  { return SignInScreen(true);}));
    }
  }
}