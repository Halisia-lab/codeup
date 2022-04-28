import 'package:flutter/material.dart';
import '/components/details_post/top_comment.dart';
import '../Profile.dart';
import '/components/post.dart';
import '/components/post_content/content_type_enum.dart';
import '/components/post_content/image_viewer.dart';
import '/components/post_content/text_viewer.dart';
import '/test_data.dart';

import '../person.dart';

class PostList extends StatefulWidget {
  const PostList();

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          trailing: GestureDetector(
            onTap: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                )),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
          ),
          title: Center(
            child: const Text(
              'SAV REDDIT',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 20.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Post(
                  TestData.personnes[0],
                  false,
                  ContentType.VIDEO,
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                  "1 Jun",
                  "Coucou je m'appelle Alexandre Paprocki, je suis en 4AL à l'ESGI",
                  "Voici ma description",
                  0,
                  TestData.comments1),
              Post(
                  TestData.personnes[1],
                  false,
                  ContentType.TEXT,
                  '',
                  "09 Jun",
                  "There are two other properties related to size: minRadius and maxRadius. They are used to set the minimum and maximum radius respectively. I",
                  "Description",
                  45,
                  TestData.comments),
              Post(
                  TestData.personnes[2],
                  true,
                  ContentType.IMAGE,
                  'https://static.fnac-static.com/multimedia/Images/FD/Comete/114332/CCP_IMG_ORIGINAL/1481839.jpg',
                  "10 Jun",
                  'Hello! For my AP subject what is the fastest growing economy?',
                  "La description",
                  4,
                  TestData.comments)
            ],
          ),
        ),
      ),
      /* floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
              onPressed: newPost,
              tooltip: 'Write a new post',
              child: Icon(Icons
                  .add)),
      )  */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
