import 'package:flutter/material.dart';

import '../../entities/person.dart';
import '../post/votes_counter.dart';

class CommentListItem extends StatelessWidget {
  final text;
  var date;
  Person commiter;
  var state;
  int _votes = 0;

  CommentListItem(this.commiter, this.text, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF656565).withOpacity(0.15),
              blurRadius: 4.0,
              spreadRadius: 1.0,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left:8, top:8, right:8, bottom:8),
        child: Row(
          children: [
            VotesCounter(_votes),
            Container(child: Expanded(child: Column(
              children: [
                Align(child: Text(this.text, style: TextStyle(fontSize: 17),), alignment: Alignment.topLeft,),
                Align(child: Text(commiter.user.firstname + " " + commiter.user.lastname,  style: TextStyle(color: Colors.black45)), alignment: Alignment.bottomRight,),
            Align(child: Text(date,  style: TextStyle(color: Colors.black45)), alignment: Alignment.bottomRight,)
            
              ],
            ))),
          ],
        ),
      ),
    );
  }
}
