import 'package:codeup/ui/common/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../common/custom_colors.dart';
import '../common/test_data.dart';

class HomeTop extends StatefulWidget {
  const HomeTop({Key? key}) : super(key: key);

  @override
  _HomeTopState createState() => _HomeTopState();
}

class _HomeTopState extends State<HomeTop> {
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomAppBar("Posts", true);
  }

  _searchOneTopic() {
    var text = _textController.text;
    var result = TestData.posts.where((element) => element.post.title == text);
  
  }
}
