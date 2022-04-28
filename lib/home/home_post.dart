import 'package:flutter/material.dart';

import '../person.dart';

class HomePost extends StatefulWidget {
  final String text;
  final Person commiter;
  const HomePost(this.text, this.commiter);

  @override
  _HomePostState createState() => _HomePostState(this.text, this.commiter);
}

class _HomePostState extends State<HomePost> {
  final String text;
  final Person commiter;

  _HomePostState(this.text, this.commiter);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 7/8,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(7)), boxShadow: [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.1),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],),
        child: Column(
          children: [
            Row(
              children: [Icon(Icons.person_rounded),
                Text(this.commiter.name),
              ],
            ),
            Text(this.text),
          ],
        )
      ),
    );
  }
}