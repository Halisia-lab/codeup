import 'package:codeup/services/forum_service.dart';
import 'package:codeup/ui/forums/forums_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../entities/forum.dart';
import '../../services/auth_service.dart';
import '../common/custom_app_bar.dart';
import '../common/custom_button.dart';
import '../common/custom_colors.dart';
import '../forums/viewModel/forum_view_model.dart';

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
  ForumService forumService = ForumService();
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
  Color currentColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: CustomScrollView(
        slivers: [
          CustomAppBar("Create a forum", false, null),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text("Preview:", style: TextStyle(fontSize: 15, color: CustomColors.darkText),),
                    Align(
                      alignment: Alignment.center,
                      child:Container(
                decoration: BoxDecoration(color: background_color),
                child: GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: Text("Pick a color"),
                            content: ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      currentColor = pickerColor;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text("Ok"))
                            ])),
                child: Container(child: Row(
                  children: [
                    const Padding(
                      padding:  EdgeInsets.all(10),
                      child:  Icon(Icons.forum_outlined, size: 60,color: Colors.white,),
                    ),
                    Flexible(child: Text(responseContent, style: const TextStyle(color: Colors.white, fontSize: 18),)),
                  ],
                ), color: currentColor,),
                ),
              ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                           bottom: 8, top: 20),
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
                          onSubmitted: (str) {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
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
                          onChanged: (str) {setState(() {
                            responseContent = str;
                          });},
                          onSubmitted: (str) {}),
                    ),
                  ],
                ),
              ),
              /* Padding(
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
              ), */
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CustomButton(
                    contentController.text.isNotEmpty &&
                            titleController.text.isNotEmpty 
                        ? CustomColors.mainYellow
                        : Colors.grey,
                    "Create",
                    contentController.text.isNotEmpty &&
                            titleController.text.isNotEmpty 
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
     final response = await forumService.addForum(
        Forum(-1, titleController.text, contentController.text, colorToHex(currentColor).toString()));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const ForumsScreen();
      }));
    }
  }
}
