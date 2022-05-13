import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/comment/comment_list_item.dart';
import 'package:codeup/ui/comment/comment_list_screen.dart';
import 'package:codeup/ui/common/test_data.dart';
import 'package:codeup/ui/saved_posts/saved_post_list.dart';
import 'package:flutter/material.dart';

import '../../entities/Person.dart';
import '../../entities/post.dart';
import '../../entities/user.dart';
import '../common/language_enum.dart';
import '../profile/profile_screen.dart';
import 'post_language_text.dart';
import 'post_box_action.dart';
import 'text_viewer.dart';
import 'votes_counter.dart';

class PostBox extends StatefulWidget {
  Post post;
  final List<LanguageValue> languages;
  int votes;
  bool isSaved;
  Person commiter;
  bool areCommentsVisible = false;
  PostBox(this.post, this.languages, this.votes, this.isSaved, this.commiter);

  @override
  _PostBoxState createState() => _PostBoxState(
      this.post, this.languages, this.votes, this.isSaved, this.commiter);
}

class _PostBoxState extends State<PostBox> {
  AuthService authService = AuthService();
  Post post;
  final List<LanguageValue> languages;
  int votes;
  bool isSaved;
  Person commiter;
  bool areCommentsVisible = false;
//this.text, this.title, this.languages, this.commiter, this.votes, this.isSaved
  _PostBoxState(
      this.post, this.languages, this.votes, this.isSaved, this.commiter);

  Future<User> getCommiter() async {
    return await authService.getUserById(this.post.userId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _getCommiterProfile(context, commiter),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Container(
                        height: 40,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(this.commiter.photoUrl),
                            radius: 30),
                      ),
                    ),
                    Text(
                      this.commiter.name,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Text(
                this.post.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(children: [
                for (LanguageValue language in languages)
                  PostLanguageText(language),
              ]),
              Row(
                children: [
                  VotesCounter(votes),
                  Flexible(child: TextViewer(this.post.content)),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: PostBoxAction(Icons.comment_outlined, "3 comments ",
                        () => _openComments(context)),
                    onTap: () => _openComments(context),
                  ),
                  GestureDetector(
                    child: PostBoxAction(
                        this.isSaved ? Icons.bookmark : Icons.bookmark_border,
                        "Save",
                        () => _save()),
                    onTap: () => _save(),
                  ),
                  GestureDetector(
                      child: PostBoxAction(
                          Icons.share_outlined, "Share", () => _share()),
                      onTap: () => _share()),
                ],
              ),
            ],
          )),
    );
  }

  _share() {
    print("write share function");
  }

  _save() {
    setState(() {
      if (isSaved) {
        isSaved = false;
        SavedPostList.savedPosts.remove(this.widget);
      } else {
        isSaved = true;
        if (!SavedPostList.savedPosts.contains(this.widget)) {
          SavedPostList.savedPosts.add(this.widget);
        }
      }
    });
  }

  _openComments(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CommentListScreen(widget);
    }));
  }

  _getCommiterProfile(BuildContext context, Person friend) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen(friend)));
  }
 
}
