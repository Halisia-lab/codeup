import 'package:codeup/services/forum_service.dart';
import 'package:codeup/ui/forums/forum_page/forum_page_screen.dart';
import 'package:flutter/material.dart';

import '../../entities/post.dart';
import '../../services/auth_service.dart';
import '../../services/post_service.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_button.dart';
import '../common/custom_colors.dart';
import '../forums/forum_list_item.dart';
import '../forums/viewModel/forum_view_model.dart';
import '../home/home_screen.dart';
import 'post_box.dart';

class EditPostScreen extends StatefulWidget {
  final PostBox post;
  static const routeName = "/editPost-screen";

  EditPostScreen(this.post);
  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final background_color = CustomColors.lightGrey3;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String responseContent = "";
  AuthService authService = AuthService();
  PostService postService = PostService();
  ForumService forumService = ForumService();
  ForumViewModel forumViewModel = ForumViewModel();
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(
        child: Text("Select forum.."), value: "empty_response"),
  ];

  String selectedForum = "empty_response";

  _EditPostScreenState();

  @override
  void initState() {
    titleController.text = widget.post.post.title;
    contentController.text = widget.post.post.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    selectedForum = widget.post.post.forumId.toString();
    return Scaffold(
      backgroundColor: background_color,
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Edit a post", false, null),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // color: CustomColors.white,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 80,
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  AuthService.currentUser!.photoUrl),
                              radius: 50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 8, top: 20),
                        child: TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              border:  OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.darkText, width: 1.0),
                              ),
                              labelText: "Title",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelStyle:  TextStyle(fontSize: 18),
                              floatingLabelStyle:  TextStyle(
                                  fontSize: 19,
                                  color: CustomColors.darkText,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.darkText, width: 2.0),
                              ),
                            ),
                            onChanged: (str) {
                              setState(() {
                                responseContent = str;
                              });
                            },
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          
                            controller: contentController,
                            maxLines: 7,
                            decoration:  const InputDecoration(
                              isDense: true,
                              border:  OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.darkText, width: 1.0),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "Your post content...",
                              labelStyle:  TextStyle(fontSize: 18),
                              floatingLabelStyle:  TextStyle(
                                  fontSize: 19,
                                  color: CustomColors.darkText,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.darkText, width: 2.0),
                              ),
                            ),
                            onChanged: (str) {
                              setState(() {
                                responseContent = str;
                              });
                            },
                            onSubmitted: (str) {}),
                      ),
                    ],
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FutureBuilder(
                      future: forumViewModel.fetchForums(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ForumListItem>> snapshot) {
                            selectedForum=widget.post.post.forumId.toString();
                        return DropdownButton(
                          value: snapshot.data == null ? "empty_response" : selectedForum,
                          items: snapshot.data != null
                              ? <DropdownMenuItem<String>>[
                                  menuItems[0],
                                  for (ForumListItem forum in snapshot.data!)
                                    DropdownMenuItem(
                                      child: Text(forum.forum.title.toString()),
                                      value: snapshot.data != null
                                          ? forum.forum.id.toString()
                                          : selectedForum,
                                    )
                                ]
                              : menuItems,
                          onChanged: (String? value) {
                            setState(() {
                              selectedForum = value.toString();
                            });
                          },
                          iconEnabledColor: CustomColors.mainYellow,
                          iconDisabledColor: Colors.grey,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.darkText),
                        );
                      }),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8),
                child: CustomButton(
                   (contentController.text.isNotEmpty &&
                                titleController.text.isNotEmpty &&
                                selectedForum != "empty_response"
                            ? CustomColors.mainYellow
                            : Colors.grey),
                        
                    "Save",(contentController.text.isNotEmpty &&
                                titleController.text.isNotEmpty &&
                                selectedForum != "empty_response"
                            ? _submitPost
                            : null)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8),
                child: CustomButton(
                    CustomColors.redText,
                        
                    "Delete post", _deletePost),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  _deletePost() async {
   print("delete");
  }

  _submitPost() async {
    final forumId = int.parse(selectedForum);
    final response = await postService.addPost(
        Post(-1, titleController.text, contentController.text, "C", forumId,
            AuthService.currentUser!.user.id, null),
        AuthService.currentUser!);

    if (response.statusCode == 200 || response.statusCode == 201) {
       {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return FutureBuilder(
              future: forumViewModel.fetchForumById(forumId),
              builder: (BuildContext context,
                  AsyncSnapshot<ForumListItem> snapshot) {
                return snapshot.data != null
                    ? ForumPageScreen(snapshot.data!)
                    : Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: CustomColors.mainYellow,
                        ));
              });
        }));
    }
  }
}
}