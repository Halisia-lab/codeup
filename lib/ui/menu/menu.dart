import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/authentication/sign_in/sign_in_screen.dart';
import 'package:codeup/ui/forums/forums_screen.dart';
import 'package:codeup/ui/friends/friends_screen.dart';
import 'package:codeup/ui/home/home_screen.dart';
import 'package:codeup/ui/saved_posts/saved_posts_screen.dart';
import 'package:flutter/material.dart';

import '../../backend/model/user.dart';
import '../../entities/Person.dart';
import '../authentication/sign_up/sign_up_screen.dart';
import '../common/custom_button.dart';
import '../common/custom_colors.dart';
import '../common/test_data.dart';
import '../profile/profile_screen.dart';
import 'menu_option.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = TestData.currentUser;
    return Drawer(
      backgroundColor: Colors.white,
      child: AuthService.currentUser != null
          ? _loggedMenuOptions(context, currentUser)
          : _loggedMenuOptions(context, currentUser),
    );
  }
}

Widget _loggedMenuOptions(BuildContext context, Person currentUser) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
          decoration: const BoxDecoration(color: Colors.white),
          child: GestureDetector(
            onTap: () => _getProfilePage(context),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Image.network(
                currentUser.photoUrl,
                height: 100,
              ),
            ),
          )),
      Center(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Text(
          currentUser.email,
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      )),
      MenuOption("Home", Icons.home, () => _getHomePage(context)),
      MenuOption("Friends", Icons.person, () => _getFriendsPage(context)),
      MenuOption(
          "Saved Posts", Icons.bookmark, () => _getFavoritesPage(context)),
      MenuOption("Forums", Icons.chat_bubble_outline_sharp,
          () => _getForumsPage(context)),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10, left: 8, right: 8),
        height: 1,
        decoration: const BoxDecoration(color: CustomColors.lightGrey3),
      ),
      //MenuOption("Logout", Icons.logout, () => _logOut(context)),
      CustomButton(CustomColors.mainYellow, "Log out", () => _logOut(context))
    ],
  );
}

Widget _unloggedMenuOptions(
  BuildContext context,
) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.white),
        child: SizedBox(
          height: 400,
        ),
      ),
      MenuOption("Home", Icons.home, () => _getHomePage(context)),
      MenuOption("Forums", Icons.chat_bubble_outline_sharp,
          () => _getForumsPage(context)),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10, left: 8, right: 8),
        height: 1,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: CustomColors.lightGrey1),
      ),
      //MenuOption("Logout", Icons.logout, () => _logOut(context)),
      CustomButton(CustomColors.mainYellow, "Log in", () => _logIn(context)),
      CustomButton(Colors.orange, "Sign up", () => _signUp(context)),
    ],
  );
}

_signUp(BuildContext context) {
  //Navigator.of(context).pop();
  Navigator.of(context).pushNamed(SignUpScreen.routeName);
}

_logIn(BuildContext context) {
  Navigator.of(context).pushNamed(SignInScreen.routeName);
}

_logOut(BuildContext context) {
  AuthService.setCurrentUser(null);
  Navigator.of(context).pop();
  Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
}

_getHomePage(BuildContext context) {
  Navigator.of(context).pushNamed(HomeScreen.routeName);
}

_getForumsPage(BuildContext context) {
  Navigator.of(context).pushNamed(ForumsScreen.routeName);
}

_getFavoritesPage(BuildContext context) {
  Navigator.of(context).pushNamed(SavedPostsScreen.routeName);
}

_getFriendsPage(BuildContext context) {
  Navigator.of(context).pushNamed(FriendsScreen.routeName);
}

_getProfilePage(BuildContext context) {
  Navigator.of(context).pushNamed(ProfileScreen.routeName);
}
