import 'package:codeup/common/custom_colors.dart';
import 'package:codeup/home/home_post_action.dart';
import 'package:codeup/home/home_post_list.dart';
import 'package:codeup/menu/home_menu.dart';
import 'package:flutter/material.dart';

import 'home_top.dart';
import '../menu/home_menu_option.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeMenu(),
      body: CustomScrollView(
        slivers: [
          HomeTop(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
               decoration: BoxDecoration(color: CustomColors.lightGrey2),
                height: MediaQuery.of(context).size.height,
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
