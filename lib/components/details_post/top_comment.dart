import 'package:flutter/material.dart';

import '../post.dart';

class TopComment extends StatelessWidget {
  final Post post;
  const TopComment(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
            color: Colors.white,
            //borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.25),
                spreadRadius: 1.0,
              )
            ]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(this.post.text, style: TextStyle(color: Colors.grey.shade800, fontSize: 15),),
            ),
    );
  }
}