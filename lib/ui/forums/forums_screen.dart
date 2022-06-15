import 'package:codeup/ui/common/search_bar_type.dart';
import 'package:codeup/ui/forums/forums_list.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../authentication/sign_in/sign_in_screen.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../menu/menu.dart';

class ForumsScreen extends StatefulWidget {
  static const routeName = "/forum-screen";
  const ForumsScreen({Key? key}) : super(key: key);

  @override
  State<ForumsScreen> createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  final background_color = CustomColors.lightGrey3;
  int number = 1;
  bool isChecked = false;
  CustomAppBar forumsTop = CustomAppBar("Forums", true, SearchBarType.FORUM);
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return CustomColors.mainYellow;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _createForum()),
        child: Icon(Icons.add),
        backgroundColor: CustomColors.mainYellow,
      ),
      backgroundColor: background_color,
      drawer: Menu(),
      body: CustomScrollView(
        slivers: [
          forumsTop,
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 8 / 10,
                child: ForumList(forumsTop),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _createForum() async {
    if (AuthService.currentUser != null) {
      Navigator.of(context).pushNamed("/createForum-screen");
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return SignInScreen(true);
      }));
    }
  }
}
