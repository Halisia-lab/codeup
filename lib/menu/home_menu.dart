import 'dart:ui';

import 'package:codeup/common/custom_button.dart';
import 'package:codeup/common/custom_colors.dart';
import 'package:codeup/menu/home_menu_profile.dart';
import 'package:flutter/material.dart';

import 'home_menu_option.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: CustomColors.white
              /* gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.9,
              ],
              colors: [
                CustomColors.mainYellow,
                Colors.orange
              ],
            ), */
            ),
            child: HomeMenuProfile(),
          ),
          HomeMenuOption("Friends", Icons.person, () => _getFriendsPage()),
          HomeMenuOption("Favorites", Icons.bookmark_border, () => _getFavoritesPage()),
          HomeMenuOption("About us", Icons.book_online, () => _getAboutUsPage()),
          Container(margin: EdgeInsets.only(top:5, bottom: 10),height: 1, width: MediaQuery.of(context).size.width, decoration: BoxDecoration(color: CustomColors.lightGrey3),),
          //HomeMenuOption("Logout", Icons.logout, () => _logOut()),
          CustomButton(CustomColors.mainYellow, "Log in", () => _logIn()),
          CustomButton(Colors.orange, "Sign up", () => _signUp()),
        ],
      ),
    );
  }
}

_signUp() {
  print("write sign up");
}

_logIn() {

  print("write log in");
}

_logOut() {
  print("write log out");
}

_getAboutUsPage() {
  print("write about us page");
}

_getFavoritesPage() {
  print("write favorites page");
}

_getFriendsPage() {
  print("write friends page");
}
