import 'components/details_post/comment.dart';
import 'components/post.dart';
import 'components/post_content/content_type_enum.dart';
import 'person.dart';

class TestData {
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

  static var comments = [
    Post(
        TestData.personnes[1],
        true,
        ContentType.TEXT,
        '',
        "09 Jun",
        "There are two other properties related to size: minRadius and maxRadius. They are used to set the minimum and maximum radius respectively. I",
        "Description",
        23, []),
    Post(
        TestData.personnes[1],
        false,
        ContentType.TEXT,
        '',
        "09 Jun",
        "There are two other properties related to size: minRadius and maxRadius. They are used to set the minimum and maximum radius respectively. I",
        "Description",
        0, []),
    Post(
        TestData.personnes[2],
        false,
        ContentType.TEXT,
        '',
        "09 Jun",
        "There are two other properties related to size: minRadius and maxRadius. They are used to set the minimum and maximum radius respectively. I",
        "Description",
        0, []),
  ];

  static var comments1 = [
    Post(
        TestData.personnes[2],
        false,
        ContentType.TEXT,
        '',
        "09 Jun",
        " They are used to set the minimum and maximum radius respectively",
        "Description",
        23, []),
  ];
}
