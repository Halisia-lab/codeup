import 'package:codeup/common/custom_colors.dart';
import 'package:codeup/common/language_enum.dart';
import 'package:codeup/components/post_content/text_viewer.dart';
import 'package:codeup/home/text_code_viewer.dart';
import 'package:codeup/home/votes_counter.dart';
import 'package:flutter/material.dart';

import '../person.dart';
import 'home_language_text.dart';
import 'home_post_action.dart';

class HomePost extends StatefulWidget {
  final String text;
  final String title;
  final List<LanguageValue> languages;
  final Person commiter;
  int votes;
  HomePost(this.text, this.title, this.languages, this.commiter, this.votes);

  @override
  _HomePostState createState() =>
      _HomePostState(this.text, this.title, this.languages, this.commiter, this.votes);
}

class _HomePostState extends State<HomePost> {
  final String text;
  final Person commiter;
  final String title;
  final List<LanguageValue> languages;
  int votes;

  _HomePostState(this.text, this.title, this.languages, this.commiter, this.votes);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: MediaQuery.of(context).size.width * 7 / 8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7)),
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
                Row(
                  children: [
                    Padding(
                          padding: EdgeInsets.only(left:10, top:10, bottom: 10),
                          child: Container(
                            height: 40,
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(this.commiter.photoUrl),
                                    
                                radius: 30),
                          ),
                        ),
                    Text(this.commiter.name),
                  ],
                ),
                
                Text(
                  this.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Row(children: [
                  for (LanguageValue language in languages)
                    HomeLanguageText(language),
                    
                ]),
                Row(
                  children: [
                VotesCounter(votes),
                    Flexible(child: TextViewer(this.text)),
                  ],
                ),
                 Row(
                  children: <Widget>[
                    HomePostAction(Icons.comment_outlined, "3 comments ", () => _openComments()),
                    HomePostAction(Icons.bookmark_border, "Save", () => _save()),
                    HomePostAction(Icons.share_outlined, "Share", () => _share()),
                    
                  ],
                ),  
              ],
            ) ),
      );
  }
}

_share() {
  print("write share function");
}

_save() {
  print("write save function");
}

_openComments() {
  print("write open comments function");
}
