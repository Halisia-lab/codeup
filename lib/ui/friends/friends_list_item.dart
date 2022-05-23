import 'package:codeup/ui/common/test_data.dart';
import 'package:codeup/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../entities/Person.dart';

class FriendsListItem extends StatelessWidget {
  final Person friend;
  FriendsListItem(this.friend);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        title: Container(
          margin: EdgeInsets.only(bottom: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(friend.photoUrl),
                  radius: 20,
                ),
              ),
              Text(friend.user.username),
            ],
          ),
        ),
        onTap: () => _getFriendPage(context, friend),
      ),
    );
  }

  _getFriendPage(BuildContext context, Person friend) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen(friend)));
  }
}
