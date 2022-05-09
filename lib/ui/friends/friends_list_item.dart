import 'package:codeup/ui/common/test_data.dart';
import 'package:flutter/material.dart';

import '../../entities/Person.dart';

class FriendsListItem extends StatelessWidget {
  final Person friend;
  FriendsListItem(this.friend);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(friend.photoUrl),
                radius: 20,
              ),
            ),
            Text(friend.name),
          ],
        ),
        onTap: () => _getFriendPage(context, friend),
      ),
    );
  }

  _getFriendPage(BuildContext context, Person friend) {
    print("go to friend page");
  }
}
