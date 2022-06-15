import 'package:codeup/services/auth_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:flutter/material.dart';

import '../authentication/sign_in/sign_in_screen.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../common/search_bar_type.dart';
import './home_post_list.dart';
import '../menu/menu.dart';
import 'home_top.dart';

//TODO ChangeNotifierProvider 
class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService postService = PostService();
  final background_color = CustomColors.lightGrey3;
  CustomAppBar homeTop = CustomAppBar("Posts", true, SearchBarType.POST);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _createPost()),
        child: Icon(Icons.add),
        backgroundColor: CustomColors.mainYellow,
      ),
      backgroundColor: background_color,
      drawer: const Menu(),
      body: CustomScrollView(
        slivers: [
          homeTop,
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 8 / 10,
                child: PostBoxList(homeTop)
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _createPost() async {
    if (AuthService.currentUser != null) {
      Navigator.of(context).pushNamed("/createPost-screen");
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return SignInScreen(true);
      }));
    }
  }
}
