import 'package:codeup/ui/common/search_bar_type.dart';
import 'package:flutter/material.dart';

import '../common/custom_app_bar.dart';
import '../common/test_data.dart';

class HomeTop extends StatefulWidget with ChangeNotifier {
   HomeTop({Key? key}) : super(key: key);

  @override
  _HomeTopState createState() => _HomeTopState();
}

class _HomeTopState extends State<HomeTop> {
  var _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomAppBar("Posts", true, SearchBarType.POST);
  }

  _searchOneTopic() {
    var text = _textController.text;
    //var result = TestData.posts.where((element) => element.post.title == text);
  
  }
}
