import 'package:flutter/material.dart';

import '../../entities/Person.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../common/test_data.dart';
import '../menu/menu.dart';
import 'friends_list_item.dart';

class FriendsScreen extends StatefulWidget {
  static const routeName = "/friends-screen";
  const FriendsScreen({ Key? key }) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final background_color = CustomColors.lightGrey3;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: background_color,
      drawer: Menu(),
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Friends", true),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 4 / 5,
                child: ListView(children: [
                  for(Person friend in TestData.personnes )
                   FriendsListItem(friend)],),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}