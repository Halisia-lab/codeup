import 'package:flutter/material.dart';

import '../../entities/person.dart';
import '../../entities/post.dart';
import '../../entities/user.dart';
import '../common/custom_colors.dart';
import '../common/test_data.dart';
import '../post/post_box.dart';
import 'language_enum.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final bool searchBar;
  TextEditingController _textController = TextEditingController();
   Iterable<Widget> res = [];
  CustomAppBar(this.title, this.searchBar);

  @override
  _CustomAppBarState createState() =>
      _CustomAppBarState(this.title, this.searchBar);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String title;
  final bool searchBar;
  //TODO pass in parameters
  List<PostBox> initPosts = [
    PostBox(
        const Post(1, "bonjour", "mycontent", "codeJS", 1, 2),
        [],
        3,
        false,
        Person(const User(2, "mail", "psw", "username", "fn", "ln"),
            TestData.personnes[0].photoUrl)),
    PostBox(
        const Post(1, "hellooo", "blablabl", "php", 1, 2),
        [LanguageValue.JAVA],
        -12,
        true,
        Person(const User(2, "mail", "psw", "username", "fn", "ln"),
            TestData.personnes[1].photoUrl)),
    PostBox(
        const Post(3, "Hola Hola", "hihihih", "Py", 1, 2),
        [],
        56,
        false,
        Person(const User(3, "mail", "psw", "username", "fn", "ln"),
            TestData.personnes[2].photoUrl)),
  ];
  _CustomAppBarState(this.title, this.searchBar);
  Iterable<dynamic> contenu = [];

  @override
  void initState() {
    widget.res = initPosts;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: CustomColors.darkText,
        iconTheme: const IconThemeData(color: Colors.white),
        floating: true,
        pinned: true,
        snap: false,
        centerTitle: false,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [],
        bottom: searchBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 8 / 9,
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      color: CustomColors.white,
                    ),
                    child: TextField(
                      controller: widget._textController,
                      decoration: InputDecoration(
                        prefixText: " ",
                        hintText: '  Search for something',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => _search(),
                          color: CustomColors.mainYellow,
                        ),
                        ),
                      onChanged: (str) {
                        if (str.length > 3) {
                          if (initPosts is List<Widget>) {
                            setState(() {
                                 widget.res = initPosts.where((element) => element.post.title.toLowerCase().contains(str.toLowerCase())) as Iterable<PostBox>;

                            });
                         
                            print(widget.res.map((e) => (e as PostBox).post.content));
                          }
                        }
                        /* setState(() {
                            var result = TestData.posts.where(
                                (element) => element.post.title.contains(str));
                          }); */
                      },
                    ),
                  ),
                ),
              )
            : PreferredSize(child: Container(), preferredSize: Size.zero));
  }


  _search() {
    var text = widget._textController.text;
    Iterable<dynamic> res = contenu;
    if (initPosts is Iterable<PostBox>) {
      res = initPosts.where((element) => element.post.title == text);
    }
    setState(() {
      contenu = res;
    });
    //var result = TestData.posts.where((element) => element.post.title == text);
    print(res);
  }
}
