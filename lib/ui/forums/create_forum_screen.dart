import 'package:codeup/ui/common/material_color_picker.dart';
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

class CreateForumScreen extends StatefulWidget {
  static const routeName = "/createForum-screen";
  @override
  _CreateForumScreenState createState() => _CreateForumScreenState();
}

class _CreateForumScreenState extends State<CreateForumScreen> {
  final background_color = CustomColors.lightGrey3;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String responseContent = "";
  AuthService authService = AuthService();
  PostService postService = PostService();
  ForumViewModel forumViewModel = ForumViewModel();
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(
        child: Text("Select color.."), value: "empty_response"),
  ];

  String selectedForum = "empty_response";

  _CreateForumScreenState();

  @override
  void initState() {
    super.initState();
  }

                // create some values
Color pickerColor = Color(0xff443a49);
Color currentColor = Color(0xff443a49);



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: background_color,
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Create a forum", false),
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
                        child: TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.darkText, width: 1.0),
                              ),
                              labelText: 'Title',
                              labelStyle: TextStyle(fontSize: 18),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 19,
                                  color: CustomColors.darkText,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                            controller: contentController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.darkText, width: 1.0),
                              ),
                              labelText: 'Description',
                              labelStyle: TextStyle(fontSize: 18),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 19,
                                  color: CustomColors.darkText,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
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
                      return DropdownButton(
                        value: selectedForum,
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
              CustomButton(Colors.red, "Color", ()=> showAboutDialog(context: context, children: [MaterialColorPicker(onColorChanged: changeColor, pickerColor: pickerColor),])),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8),
                child: CustomButton(
                    contentController.text.isNotEmpty &&
                            titleController.text.isNotEmpty &&
                            selectedForum != "empty_response"
                        ? CustomColors.mainYellow
                        : Colors.grey,
                    "Create",
                    contentController.text.isNotEmpty &&
                            titleController.text.isNotEmpty &&
                            selectedForum != "empty_response"
                        ? _submitForum
                        : null),
              ),
            ]),
          ),
        ],
      ),
    );
  }
void changeColor(Color color) {
  setState(() => pickerColor = color);
}
  

  _submitForum() async {
   /*  final response = await postService.addPost(
        Post(-1, titleController.text, contentController.text, "C", int.parse(selectedForum) ,
            AuthService.currentUser!.user.id, null),
        AuthService.currentUser!);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const HomeScreen();
      }));
    } */
  }
}
