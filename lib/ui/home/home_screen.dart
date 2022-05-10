import 'package:codeup/services/auth_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../common/custom_colors.dart';
import './home_post_list.dart';
import '../menu/home_menu.dart';
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
      backgroundColor: background_color,
      drawer: HomeMenu(),
      body: /* Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FutureBuilder(
                  future: httpService.getUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<User>> snapshot) {
                    if (snapshot.hasData) {
                      List<User> users = snapshot.data!;
                      return SizedBox(
                          height: MediaQuery.of(context).size.height - 310,
                          child: UserList(
                            users,
                          ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ), */CustomScrollView(
        slivers: [
          HomeTop(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
               decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 4/5,
                /**/child: HomePostList(),
              ),
              /* Container(
                height: 1000,
                color: CustomColors.lightGrey2,
              ), */
            ]),
          ),
        ],
      ),
    );
    /* Scaffold(
      backgroundColor: CustomColors.lightGrey2,
      drawer: HomeMenu(),
      appBar: _getAppBar(),
      body: Container(child: HomePostList(),),
      
    ); */
  }
}
