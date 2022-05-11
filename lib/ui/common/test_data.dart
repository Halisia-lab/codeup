import 'package:codeup/entities/post.dart';
import 'package:codeup/ui/forums/forums_list_item.dart';
import 'package:flutter/material.dart';

import '../../entities/Person.dart';
import '../post/post_box.dart';
import './language_enum.dart';

class TestData {
          static var personnes = [
    Person(
        1,
        "Romain Kamiri",
        "romain.romain@gmail.com",
        "***",
        "test",
        "https://cdn.pixabay.com/photo/2017/02/23/13/05/profile-2092113_960_720.png"),
    Person(1, "Halisia Halifa", "halifa.halisia@gmail.com", "***", "test",
        "https://previews.123rf.com/images/gmast3r/gmast3r1710/gmast3r171002129/88668387-female-avatar-profile-vector-illustration.jpg"),
    Person(1, "Thomas Lemaire", "thomas.thomas@gmail.com", "***", "test",
        "https://static.vecteezy.com/system/resources/previews/002/275/847/original/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg")
  ];
  
  var currentUser = TestData.personnes[1];
  static List<PostBox> posts = [
    
    PostBox(Post(1,"Title", "Nouveau post", "JAVA", 1, 1), [LanguageValue.C, LanguageValue.JAVA], 4, false, TestData.personnes[1] ),
             PostBox(Post(1,"Title", "Nouveau post", "JAVA", 1, 1),
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
        
  static List<ForumListItem> forums = [
            ForumListItem("JavaScript", Icons.javascript, false, 1),
            ForumListItem("Php", Icons.php, true, 2),
            ForumListItem("Kotlin", Icons.android, false, 3),
            ];


}