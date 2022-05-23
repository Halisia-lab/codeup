import 'package:flutter/material.dart';

import '../common/custom_colors.dart';
import '../common/test_data.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final bool searchBar;
  const CustomAppBar(this.title, this.searchBar);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(this.title, this.searchBar);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String title;
  final bool searchBar;
  _CustomAppBarState(this.title, this.searchBar);

  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: CustomColors.darkText,
        iconTheme: IconThemeData(color: Colors.white),
        floating: true,
        pinned: true,
        snap: false,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [],
        bottom: searchBar ? PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 8 / 9,
              height: 40,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: CustomColors.white,
              ),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  prefixText: " ",
                  hintText: '  Search for something',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _searchOneTopic(),
                    color: CustomColors.mainYellow,
                  ),
                  //suffixIcon: GestureDetector(onTap: ()=> print("add camera function"),child: Icon(Icons.camera_alt, color: CustomColors.darkText,))
                ),
                onChanged: (str) {
                  if (str.length > 3)
                    setState(() {
                      var result = TestData.posts
                          .where((element) => element.post.title.contains(str));
                    });
                },
              ),
            ),
          ),
        ) : PreferredSize(child: Container(), preferredSize: Size.zero));
  }

  _searchOneTopic() {
    var text = _textController.text;
    var result = TestData.posts.where((element) => element.post.title == text);
  }
}
