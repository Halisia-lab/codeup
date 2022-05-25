import 'package:codeup/services/auth_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:flutter/material.dart';

import '../authentication/sign_in/sign_in_screen.dart';
import '../common/custom_colors.dart';
import './home_post_list.dart';
import '../menu/menu.dart';
import 'home_top.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService postService = PostService();
  final background_color = CustomColors.lightGrey3;
  @override
  Widget build(BuildContext context) {
    //postService.getPosts();
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
          const HomeTop(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 4 / 5,
                child: PostBoxList("hell"),
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
