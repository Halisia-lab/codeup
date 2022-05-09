import 'package:flutter/material.dart';

import './user.dart';

class UserList extends StatelessWidget {
    final List<User> users;

    UserList(this.users);

    @override
    Widget build(BuildContext context) {
        return ListView.separated(
          
                separatorBuilder: (context, index) {
            return Divider(color: Color.fromARGB(255, 68, 68, 68));
        },
        itemCount: users.length,
                itemBuilder: (context, index) {
            final user = users[index];

            return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
            Text("${user.id}",
                    style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.w500)),
            Text("${user.email}",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20))
              ]),
            trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
            Text(
                    "${user.firstname}",
                    style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
             Text(
                    "${user.lastname}",
                    style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 15,
                  ),
                ),
            ],
          ),
        );
        },
    );
    }
}