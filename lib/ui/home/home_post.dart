
import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/common/test_data.dart';
import 'package:codeup/ui/saved_posts/saved_post_list.dart';
import 'package:flutter/material.dart';

import '../../entities/Person.dart';
import '../../entities/post.dart';
import '../../entities/user.dart';
import '../common/language_enum.dart';
import 'home_language_text.dart';
import 'home_post_action.dart';
import 'text_viewer.dart';
import 'votes_counter.dart';



class HomePost extends StatefulWidget {
  Post post;
  final List<LanguageValue> languages;
  int votes;
  bool isSaved;
  Person commiter;
  HomePost(this.post, this.languages, this.votes, this.isSaved, this.commiter);

  @override
  _HomePostState createState() =>
      _HomePostState(this.post, this.languages, this.votes, this.isSaved, this.commiter);
}

class _HomePostState extends State<HomePost> {
  AuthService authService = AuthService();
  Post post;
  final List<LanguageValue> languages;
  int votes;
  bool isSaved;
  Person commiter;
//this.text, this.title, this.languages, this.commiter, this.votes, this.isSaved
  _HomePostState(this.post, this.languages, this.votes, this.isSaved, this.commiter);

  Future<User> getCommiter() async {
    
    return await authService.getUserById(this.post.userId);
  }

 

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
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
                    Text(this.commiter.name, style: TextStyle(fontSize: 17),),
                  ],
                ),
                
                Text(
                  this.post.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                ),
                Row(children: [
                  for (LanguageValue language in languages)
                    HomeLanguageText(language),
                    
                ]),
                Row(
                  children: [
                VotesCounter(votes),
                    Flexible(child: TextViewer(this.post.content)),
                  ],
                ),
                 Row(
                  children: <Widget>[
                    GestureDetector(child: HomePostAction(Icons.comment_outlined, "3 comments ", () => _openComments()), onTap: () => _openComments(),),
                    GestureDetector(child: HomePostAction(this.isSaved ? Icons.bookmark : Icons.bookmark_border, "Save", () => _save()), onTap: () => _save(),),
                    GestureDetector(child: HomePostAction(Icons.share_outlined, "Share", () => _share()), onTap: () => _share()),
                    
                  ],
                ),  
              ],
            ) ),
      );
  }

  _share() {
  print("write share function");
}

_save() {
  setState(() {
    if(isSaved) {
    isSaved = false;
    SavedPostList.savedPosts.remove(this.widget);
  } else {
    isSaved = true;
    if(!SavedPostList.savedPosts.contains(this.widget)) {
      SavedPostList.savedPosts.add(this.widget);
    }
  }
  });
  
}

_openComments() {
  print("write open comments function");
}

}

