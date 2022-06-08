import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/utils/date_helper.dart';
import 'package:flutter/material.dart';

import '../../entities/comment.dart';
import '../../entities/person.dart';
import '../post/votes_counter.dart';
import '../profile/profile_screen.dart';

class CommentListItem extends StatelessWidget {
  Comment comment;
  var date;
  Person commiter;
  var state;
  int _votes = 0;

  CommentListItem(this.comment, this.commiter, this.date);

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
        padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
        child: Row(
          children: [
            VotesCounter(_votes),
            Container(
                child: Expanded(
                    child: Column(
              children: [
                Align(
                  child: Text(
                    this.comment.content,
                    style: TextStyle(fontSize: 17),
                  ),
                  alignment: Alignment.topLeft,
                ),

                GestureDetector(
                  onTap: () => _getCommiterProfile(context, this.commiter),
                  child: Align(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(commiter.photoUrl),
                              radius: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:6.0),
                          child: Text(
                              commiter.user.firstname +
                                  " " +
                                  commiter.user.lastname,
                              style: TextStyle(color: CustomColors.mainPurple)),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                ),
                //TODO: add when date is available
                //Align(child: Text(date,  style: TextStyle(color: Colors.black45)), alignment: Alignment.bottomRight,)
              ],
            ))),
          ],
        ),
      ),
    );
  }

  _getCommiterProfile(BuildContext context, Person user) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ProfileScreen(user, true)));
  }
}
