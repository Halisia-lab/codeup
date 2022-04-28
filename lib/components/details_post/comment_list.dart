import 'package:flutter/material.dart';
import '../../components/post_content/content_type_enum.dart';
import '../../components/details_post/comment.dart';
import '../../components/details_post/question.dart';

import '../../test_data.dart';
import '../post.dart';

class CommentList extends StatelessWidget {
  final Post post;
  CommentList(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Responses to " + post.person.name),),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 20.0, bottom: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children:  [
              Question(this.post),
              SizedBox(height: 8.0),
              for(var comment in post.comments) comment,]  
          ),
        ),
      ),
    );
  }
}