import 'package:codeup/ui/common/custom_colors.dart';
import 'package:flutter/material.dart';

import '../common/test_data.dart';
import 'forums_list_item.dart';

class ForumList extends StatelessWidget {
  const ForumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8, left: 10.0),
        child: /* Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (ForumListItem forum in TestData.forums)
            Row(
              children: [
                Text(
                  forum.number.toString() + ' -',
                  style: TextStyle(fontSize: 20),
                ),
                forum
              ],
            ),
        ],
      ), */
          ListView(
          padding: const EdgeInsets.all(2),
          children: <Widget>[
            for(ForumListItem forumListItem in TestData.forums)
                ListTile(leading: Icon(Icons.javascript, size: 45,color: CustomColors.mainYellow),title: ForumListItem(forumListItem.name, forumListItem.icon, forumListItem.isJoined, forumListItem.number), onTap: () => print("open forum"), style: ListTileStyle.list,)
              
            
          ],
        ));
  }
}
