import 'package:flutter/material.dart';


import '../../entities/Person.dart';
import '../common/test_data.dart';
import '../home/home_post.dart';

class SavedPostList extends StatefulWidget {
  const SavedPostList({ Key? key }) : super(key: key);

  @override
  _SavedPostListState createState() => _SavedPostListState();
}

class _SavedPostListState extends State<SavedPostList> {
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
            if(post.isSaved)
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