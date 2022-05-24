import 'package:flutter/material.dart';

import '../../entities/person.dart';
import '../../entities/post.dart';
import '../../services/auth_service.dart';
import '../comment/comment_list_screen.dart';
import '../common/language_enum.dart';
import '../profile/profile_screen.dart';
import '../saved_posts/saved_post_list.dart';
import 'post_language_text.dart';
import 'post_box_action.dart';
import 'text_viewer.dart';
import 'viewModel/post_view_model.dart';
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
  _PostBoxState createState() =>
      _PostBoxState(post, languages, votes, isSaved, commiter);
}

class _PostBoxState extends State<PostBox> {
  AuthService authService = AuthService();
  Post post;
  final List<LanguageValue> languages;
  int votes;
  bool isSaved;
  Person commiter;
  bool areCommentsVisible = false;
  PostViewModel postViewModel = PostViewModel();
//this.text, this.title, this.languages, this.commiter, this.votes, this.isSaved
  _PostBoxState(
      this.post, this.languages, this.votes, this.isSaved, this.commiter);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    /* return FutureBuilder(future: postViewModel.getCommiter(post), builder: (BuildContext context, AsyncSnapshot<Person> snapshot) { */ return Padding(
      padding: const EdgeInsets.only(bottom: 10, left:10, right:10),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
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
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: SizedBox(
                        height: 40,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(commiter.photoUrl),
                            radius: 30),
                      ),
                    ),
                    Text(
                      commiter.user.firstname + " " + commiter.user.lastname,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Text(
                post.title,
                style: const TextStyle(
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
                  Flexible(child: TextViewer(post.content)),
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
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ProfileScreen(friend)));
  }
}
