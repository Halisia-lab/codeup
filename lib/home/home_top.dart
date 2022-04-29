import 'package:codeup/common/custom_colors.dart';
import 'package:codeup/common/test_data.dart';
import 'package:flutter/material.dart';

class HomeTop extends StatefulWidget {
  const HomeTop({Key? key}) : super(key: key);

  @override
  _HomeTopState createState() => _HomeTopState();
}

class _HomeTopState extends State<HomeTop> {
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: CustomColors.white,
        floating: true,
        pinned: true,
        snap: false,
        centerTitle: false,
        title: Text(
          'Posts',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 8 / 9,
              height: 40,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
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
                          .where((element) => element.title.contains(str));
                      print(result.map((e) => e.text));
                    });
                },
              ),
            ),
          ),
        ));
  }

  _searchOneTopic() {
    var text = _textController.text;
    var result = TestData.posts.where((element) => element.title == text);
    
    print(result.map((e) => e.text));
  }
}
