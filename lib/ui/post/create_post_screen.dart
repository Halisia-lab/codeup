import 'package:codeup/services/auth_service.dart';
import 'package:codeup/services/post_service.dart';
import 'package:codeup/ui/comment/comment_list_screen.dart';
import 'package:codeup/ui/common/custom_app_bar.dart';
import 'package:codeup/ui/post/createPost/drop_down_languages.dart';
import 'package:codeup/ui/post/viewMosel/post_view_model.dart';
import 'package:codeup/ui/saved_posts/saved_post_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../entities/Person.dart';
import '../../entities/post.dart';
import '../common/custom_colors.dart';
import '../common/language_enum.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import 'post_language_text.dart';
import 'post_box_action.dart';
import 'text_viewer.dart';
import 'votes_counter.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = "/createPost-screen";

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final background_color = CustomColors.lightGrey3;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String titleValue = "";
  String contentValue = "";
  AuthService authService = AuthService();
  PostService postService = PostService();

  _CreatePostScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
    return Scaffold(
      backgroundColor: background_color,
      body: CustomScrollView(
        slivers: [
          const CustomAppBar("Create a post", false),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                       /*  Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image.network(
              AuthService.currentUser!.photoUrl,
              height: 120, 
            
      )), */
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15.0),
                              hintText: "Title",
                              hintStyle: GoogleFonts.notoSans(
                                color: CustomColors.lightGrey1,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              border: border,
                            ),
                            controller: titleController,
                            onChanged: (str) {
                              setState(() {
                                titleValue = str;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            
                            textInputAction: TextInputAction.next,
                            maxLines: 7,
                            decoration: InputDecoration(
                              
                              isDense: true,
                              contentPadding: const EdgeInsets.all(15.0),
                              hintText: "What do you want to say ? ",
                              hintStyle: GoogleFonts.notoSans(
                                color: CustomColors.lightGrey1,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              border: border,
                            ),
                            controller: contentController,
                            onChanged: (str) {
                              setState(() {
                                contentValue = str;
                              });
                            },
                          ),
                        ),
                        DropDownLanguages()
                      ],
                    ),
                  ),
                ),
              ),
              /* Container(
                decoration: BoxDecoration(color: background_color),
                height: MediaQuery.of(context).size.height * 4 / 5,
                child: Row(children: [
                  Expanded(
                    child: SizedBox(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 1),
                        child: TextField(
                            controller: postController,
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
                      onTap: responseContent.isNotEmpty ? _submitPost : null,
                      child: Icon(
                        Icons.send_rounded,
                        size: 29.0,
                        color: responseContent.isNotEmpty
                            ? CustomColors.mainYellow
                            : Colors.grey,
                      ),
                    ),
                  ),
                ]),
              ), */
            ]),
          ),
        ],
      ),
    );
  }

  _submitPost() async {
    final response = await postService.addPost(
        Post(-1, "Welcome", titleValue, "C", 1,
            AuthService.currentUser!.user.id),
        AuthService.currentUser!);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeScreen();
      }));
    }
  }
}
