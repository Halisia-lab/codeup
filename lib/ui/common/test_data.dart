import 'package:codeup/entities/post.dart';
import 'package:codeup/ui/forums/forum_list_item.dart';
import 'package:flutter/material.dart';

import '../../entities/person.dart';
import '../../entities/user.dart';
import '../post/post_box.dart';
import './language_enum.dart';

class TestData {
          static var personnes = [
             Person(const User(1, "romain@mail.com", "rerf", "Romrom", "Romain", "Kamiri"), TestData.photos[0]),
              Person(const User(2, "halisia@mail.com", "rerf", "Halis", "Halisia", "Halifa"), TestData.photos[1]),
              Person(const User(3, "thomas@mail.com", "rerf", "Thotho", "Thomas", "Lemaire"), TestData.photos[2])
          ];

   static var photos = [ 
    
        "https://cdn.pixabay.com/photo/2017/02/23/13/05/profile-2092113_960_720.png",
   "https://previews.123rf.com/images/gmast3r/gmast3r1710/gmast3r171002129/88668387-female-avatar-profile-vector-illustration.jpg",
        "https://static.vecteezy.com/system/resources/previews/002/275/847/original/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg"
  ];
  
  //static var currentUser = TestData.personnes[1];
  static List<PostBox> posts = [
    
    PostBox(Post(1,"I need urgent heeelp", " have a problem while launching java. Can you help meeeee", "JAVA", 1, 1), [LanguageValue.C, LanguageValue.PYTHON, LanguageValue.JAVA], 4, false, TestData.personnes[1] ),
             PostBox(Post(1,"Hello my name is Romain", "Nouveau post", "JAVA", 1, 1),
                [LanguageValue.C, LanguageValue.JAVA], 4, true, TestData.personnes[0]),
           /* PostBox(
                "hello this is my post. hello this is my post, hello this is my post, hello this is my post. hello this is my post. hello this is my post, hello this is my post, hello this is my post. hello this is my post. hello this is my post, hello this is my post, hello this is my post. ",
                "I have a problem while launching java. ",
                [LanguageValue.JAVA],
                TestData.personnes[1],
                33, false),
           /*  PostBox(
                "bonjour",
                "Le titre de mon post est",
                [LanguageValue.C, LanguageValue.JAVA, LanguageValue.PYTHON],
                TestData.personnes[1],
                -1), */
            PostBox(
                "hello this is my post",
                "I have a problem while launching java",
                [LanguageValue.JAVA],
                TestData.personnes[2],
                0, true) */];
        
  static List<ForumListItem> forums = [/* 
            ForumListItem("JavaScript", Icons.javascript, false, 1),
            ForumListItem("Php", Icons.php, true, 2),
            ForumListItem("Kotlin", Icons.android, false, 3),
           */  ];


}