import 'package:codeup/common/custom_colors.dart';
import 'package:flutter/material.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
            ));
  }
}