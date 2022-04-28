import 'package:codeup/test_data.dart';
import 'package:flutter/material.dart';

import '../person.dart';
import 'home_post.dart';

class HomePostList extends StatelessWidget {
  const HomePostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person currentUser = TestData.personnes[1];
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [HomePost("Nouveau post", currentUser), HomePost("bonjour", currentUser), HomePost("hello this is my post", currentUser)],
          ),
        ),
      ),
    );
  }
}
