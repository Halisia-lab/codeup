import 'package:codeup/common/custom_colors.dart';
import 'package:codeup/home/home_post_list.dart';
import 'package:codeup/menu/home_menu.dart';
import 'package:flutter/material.dart';

import 'home_top.dart';

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
          /* SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: Text(
              'Posts',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 8 / 9,
                  //alignment: AlignmentDirectional.topEnd,
                  height: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for something',
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.darkText,
                      ),
                      //suffixIcon: GestureDetector(onTap: ()=> print("add camera function"),child: Icon(Icons.camera_alt, color: CustomColors.darkText,))
                    ),
                  ),
                ),
              ),
            ), */
            /* bottom: AppBar(
              
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search for something',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: GestureDetector(onTap: ()=> print("add camera function"),child: Icon(Icons.camera_alt))),
                  ),
                ),
              ),
            ), */
            HomeTop()
          ,
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 400,
                child: HomePostList(),
              ),
              Container(
                height: 1000,
                color: CustomColors.lightGrey2,
              ),
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
