
import 'package:flutter/material.dart';

import '../../entities/post.dart';
import '../../services/auth_service.dart';
import '../../services/post_service.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_colors.dart';
import '../home/home_screen.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = "/createPost-screen";

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final background_color = CustomColors.lightGrey3;
  TextEditingController postController = TextEditingController();
  String responseContent = "";
  AuthService authService = AuthService();
  PostService postService = PostService();

  _CreatePostScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Create a post", false),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(height: 200, color: Colors.white, child: Column(children: [
                  Text("Title"),
                  TextField(
                            controller: postController,
                            decoration: const InputDecoration(
                              //labelStyle: TextStyle(color: Colors.orange),
                              hintText: 'Add a reponse...',
                            ),
                            
                            onChanged: (str) {
                              setState(() {
                                responseContent = str;
                              });
                            },
                            onSubmitted: (str) {}),
                      
                    
                  Text("Content")
                ],),),
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
          Post(-1, "Welcome", responseContent, "C", 1,
              AuthService.currentUser!.user.id),
          AuthService.currentUser!);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return HomeScreen();
        }));
      }
  }
}
