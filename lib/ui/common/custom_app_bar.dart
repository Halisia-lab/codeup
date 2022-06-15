import 'package:codeup/ui/common/search_bar_type.dart';
import 'package:codeup/ui/home/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../common/custom_colors.dart';

class CustomAppBar extends StatefulWidget with ChangeNotifier {
  final String title;
  final bool searchBar;
  final SearchBarType? searchBarType;
  TextEditingController textController = TextEditingController();
  static String searchValue = "";
  String valueSearch = "";
  CustomAppBar(this.title, this.searchBar, this.searchBarType);

  @override
  _CustomAppBarState createState() =>
      _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  _CustomAppBarState();

  @override
  void initState() {
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
          widget.title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        bottom: widget.searchBar
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
                      controller: widget.textController,
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
                        if (str.isEmpty) {
                          setState(() {
                            widget.valueSearch = "";
                          });

                          FocusScope.of(context).requestFocus(FocusNode());
                          widget.notifyListeners();
                        }
                      },
                    ),
                  ),
                ),
              )
            : PreferredSize(child: Container(), preferredSize: Size.zero));
  }

  _search() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      if (widget.textController.text.length >= 2) {
        CustomAppBar.searchValue = widget.textController.text;
        widget.valueSearch = widget.textController.text;
      } else {
        CustomAppBar.searchValue = "";
        widget.valueSearch = "";
      }
    });
    widget.notifyListeners();
  }
}
