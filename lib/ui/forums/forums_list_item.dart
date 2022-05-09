import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/ui/forums/forums_join_button.dart';
import 'package:flutter/material.dart';

class ForumListItem extends StatefulWidget {
  final String name;
  final IconData icon;
  bool isJoined;
  int number;
  ForumListItem(this.name, this.icon, this.isJoined, this.number);

  @override
  State<ForumListItem> createState() => _ForumListItemState(this.name, this.icon, this.isJoined, this.number);
}

class _ForumListItemState extends State<ForumListItem> {
  _ForumListItemState(this.name, this.icon, this.isJoined, this.number);
  final String name;
  final IconData icon;
  bool isJoined;
  int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Row(children: [Icon(icon, size: 45,color: CustomColors.mainYellow,), Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(name, style: TextStyle(fontSize: 18),),
        ), if(!isJoined)  ForumJoinButton()]),
      ),
    );
  }
}