import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../authentication/sign_in/sign_in_screen.dart';
import '../common/custom_colors.dart';
import '../common/test_data.dart';
import '../post/post_box.dart';
import 'comment_list_item.dart';

class CommentListScreen extends StatefulWidget {
  static const routeName = "/CommentListScreen-screen";
  final PostBox post;
  CommentListScreen(this.post);

  @override
  // ignore: no_logic_in_create_state
  _CommentListScreenState createState() => _CommentListScreenState(post);
}

class _CommentListScreenState extends State<CommentListScreen> {
  _CommentListScreenState(this.post);

  final PostBox post;
  final commentController = TextEditingController();
  late String responseContent;
  List<CommentListItem> comments = [
    CommentListItem(
        TestData.personnes[0], "coucou commentaire", DateTime.now().toString()),
    CommentListItem(
        TestData.personnes[2], "Helloooooooo", DateTime.now().toString())
  ];

  @override
  void initState() {
    responseContent = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Responses to " + post.commiter.user.firstname),
        ),
        backgroundColor: CustomColors.lightGrey3,
        body: _getBody(),
        bottomSheet: _getResponseArea());
  }

  void sendResponse() {
    const snackBar = SnackBar(
      content: Text('Response sent'),
      backgroundColor: CustomColors.mainYellow,
    );
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    commentController.clear();
    responseContent = "";

    //TODO insert a new comment
  }

  Widget _getResponseArea() {
    return AuthService.currentUser != null
        ? Row(children: [
            Expanded(
              child: Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 1),
                  child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        //labelStyle: TextStyle(color: Colors.orange),
                        hintText: 'Add a reponse...',
                        border: InputBorder.none,
                      ),
                      onChanged: (str) {
                        setState(() {
                          responseContent = str;
                        });
                      },
                      onSubmitted: (str) {}),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, right: 8),
              child: GestureDetector(
                onTap: responseContent.isNotEmpty
                    ? () => setState(() {
                          comments.insert(
                              0,
                              CommentListItem(post.commiter, responseContent,
                                  DateTime.now().toString()));

                          sendResponse();
                        })
                    : null,
                child: Icon(
                  Icons.send_rounded,
                  size: 29.0,
                  color: responseContent.isNotEmpty
                      ? CustomColors.mainYellow
                      : Colors.grey,
                ),
              ),
            ),
          ])
        : GestureDetector(
          onTap: () => _goToSignInScreen(context),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: CustomColors.mainYellow,
                child: const Center(
                    child: Text("Log in to answer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )))));
  }

  Widget _getBody() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0, bottom: 10.0),
      child: ListView(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              GestureDetector(
                child: post,
                onTap: null,
              ),
              for (CommentListItem comment in comments) comment,
            ]),
          ),
        ],
      ),
    );
  }

  void _goToSignInScreen(BuildContext context) {
    Navigator.of(context).pushNamed(SignInScreen.routeName);
  }
}
