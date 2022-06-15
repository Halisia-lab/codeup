import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/ui/forums/viewModel/forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_app_bar.dart';
import 'forum_list_item.dart';

class ForumList extends StatefulWidget {

  final CustomAppBar forumsTop;
  ForumList(this.forumsTop);

  @override
  _ForumListState createState() => _ForumListState();
}

class _ForumListState extends State<ForumList> {
  ForumViewModel forumViewModel = ForumViewModel();
  final background_color = CustomColors.lightGrey3;
  bool isChecked = false;
  late Future<List<ForumListItem>> forums;
  Color getColor(Set<MaterialState> states) {
    return CustomColors.mainYellow;
  }

  @override
  Widget build(BuildContext context) {
  forums = isChecked
            ? forumViewModel.fetchForumsOfUser()
            : forumViewModel.fetchForums();
    return ChangeNotifierProvider(
      create: (context) => widget.forumsTop,
      child: FutureBuilder(
          future: forums,
          builder: (BuildContext context,
              AsyncSnapshot<List<ForumListItem>> snapshot) {
            return snapshot.data != null
                ? Consumer<CustomAppBar>(
                  builder: (context, appBar, child) {
                    return ListView(
                        children: [
                          if (AuthService.currentUser != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  const Text("The forums I joined only",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16)),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(getColor),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          for (ForumListItem forum
                              in snapshot.data as List<ForumListItem>)
                            (forum.forum.title.toLowerCase().contains(appBar.valueSearch.toLowerCase()) || forum.forum.description.toLowerCase().contains(appBar.valueSearch.toLowerCase())) ? forum : Container()
                        ],
                      );
                  }
                )
                : Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: CustomColors.mainYellow,
                    ));
          }),
    );
  }
}
