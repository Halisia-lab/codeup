import 'package:flutter/material.dart';


import '../../entities/Person.dart';
import '../common/test_data.dart';
import '../post/post_box.dart';

class PostBoxList extends StatefulWidget {
  const PostBoxList({ Key? key }) : super(key: key);

  @override
  _PostBoxListState createState() => _PostBoxListState();
}

class _PostBoxListState extends State<PostBoxList> {
  @override
  Widget build(BuildContext context) {
    Person currentUser = TestData.currentUser;
    List<PostBox> posts = TestData.posts;
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 20.0, bottom: 0.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            
             for(PostBox post in posts) 
            post
          ],
        )
            /* child: Column(
            children: [PostBox("Nouveau post", "Title", [LanguageEnum.C, LanguageEnum.JAVA], currentUser), PostBox("bonjour", "Le titre de mon post est", [LanguageEnum.C, LanguageEnum.JAVA, LanguageEnum.PYTHON], currentUser), PostBox("hello this is my post", "I have a problem while launching java", [LanguageEnum.JAVA], currentUser)],
          ), */
            ),
      ),
    );
  }

}