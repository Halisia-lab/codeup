import 'package:codeup/home/home_post.dart';

import '../person.dart';
import 'language_enum.dart';

class TestData {
  var currentUser = TestData.personnes[1];
  static List<HomePost> posts = [
            HomePost("Nouveau post", "Title",
                [LanguageValue.C, LanguageValue.JAVA], TestData.personnes[1], 4),
            HomePost(
                "hello this is my post. hello this is my post, hello this is my post, hello this is my post. hello this is my post. hello this is my post, hello this is my post, hello this is my post. hello this is my post. hello this is my post, hello this is my post, hello this is my post. ",
                "I have a problem while launching java. ",
                [LanguageValue.JAVA],
                TestData.personnes[1],
                33),
            HomePost(
                "bonjour",
                "Le titre de mon post est",
                [LanguageValue.C, LanguageValue.JAVA, LanguageValue.PYTHON],
                TestData.personnes[1],
                -1),
            HomePost(
                "hello this is my post",
                "I have a problem while launching java",
                [LanguageValue.JAVA],
                TestData.personnes[1],
                0)];
          


          static var personnes = [
    Person(
        1,
        "Alexandre Paprocki",
        "alexandre.alexandre@gmail.com",
        "***",
        "test",
        "https://cdn.pixabay.com/photo/2017/02/23/13/05/profile-2092113_960_720.png"),
    Person(1, "Halisia Halifa", "halifa.halisia@gmail.com", "***", "test",
        "https://previews.123rf.com/images/gmast3r/gmast3r1710/gmast3r171002129/88668387-female-avatar-profile-vector-illustration.jpg"),
    Person(1, "Ichai Chitski", "ichai.ichai@gmail.com", "***", "test",
        "https://static.vecteezy.com/system/resources/previews/002/275/847/original/male-avatar-profile-icon-of-smiling-caucasian-man-vector.jpg")
  ];

}