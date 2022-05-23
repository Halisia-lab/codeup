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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      drawer: Menu(),
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Forums", true),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 4 / 5,
                child: ForumList(),
              ),
            ]),
          ),
        ],
      ),
    );
  }


}
