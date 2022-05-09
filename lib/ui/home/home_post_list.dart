import 'package:flutter/material.dart';


import '../../entities/Person.dart';
import '../common/test_data.dart';
import 'home_post.dart';

class HomePostList extends StatefulWidget {
  const HomePostList({ Key? key }) : super(key: key);

  @override
  _HomePostListState createState() => _HomePostListState();
}

class _HomePostListState extends State<HomePostList> {
  @override
  Widget build(BuildContext context) {
    Person currentUser = TestData.personnes[1];
    List<HomePost> posts = TestData.posts;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 20.0, bottom: 0.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            
             for(HomePost post in posts) 
            post
          ],
        )
            /* child: Column(
            children: [HomePost("Nouveau post", "Title", [LanguageEnum.C, LanguageEnum.JAVA], currentUser), HomePost("bonjour", "Le titre de mon post est", [LanguageEnum.C, LanguageEnum.JAVA, LanguageEnum.PYTHON], currentUser), HomePost("hello this is my post", "I have a problem while launching java", [LanguageEnum.JAVA], currentUser)],
          ), */
            ),
      ),
    );
  }

}