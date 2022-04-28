import 'package:flutter/material.dart';

//AppBar must PreferredSizeWidget
class AppSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function setValueSearchBar;
  const AppSearchBar({Key? key, required this.setValueSearchBar})
      : super(key: key);

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(50); // size in height of AppBar
}

class _AppSearchBarState extends State<AppSearchBar> {
  late Function setValueSearchBar;
  @override
  void initState() {
    super.initState();
    setValueSearchBar = widget.setValueSearchBar;
  }

  Icon customIcon = const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    Widget customAppBarTitle = const Text('SAV REDDIT');
    Widget customAppBarSearch = ListTile(
      leading: Icon(
        Icons.search,
        color: Colors.white,
        size: 28,
      ),
      title: TextField(
        onChanged: (value) => setValueSearchBar(value),
        decoration: InputDecoration(
          hintText: 'Put your key-word',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    return AppBar(
      title: customIcon.icon == Icons.search
          ? customAppBarTitle
          : customAppBarSearch,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = const Icon(Icons.cancel);
              } else {
                customIcon = const Icon(Icons.search);
              }
            });
          },
          icon: customIcon,
        )
      ],
      centerTitle: true,
    );
  }
}
