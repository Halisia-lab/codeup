import 'package:codeup/services/auth_service.dart';
import 'package:codeup/ui/authentication/sign_in/sign_in_screen.dart';
import 'package:codeup/ui/forums/forums_screen.dart';
import 'package:codeup/ui/friends/friends_screen.dart';
import 'package:codeup/ui/home/home_screen.dart';
import 'package:codeup/ui/saved_posts/saved_posts_screen.dart';
import 'package:flutter/material.dart';

import '../authentication/sign_up/sign_up_screen.dart';
import '../common/custom_button.dart';
import '../common/custom_colors.dart';
import '../common/test_data.dart';
import '../profile/profile_screen.dart';
import 'home_menu_option.dart';
import 'home_menu_profile.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final currentUser = TestData.personnes[1];
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white
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
            child:  
          AuthService.currentUser != null ? GestureDetector(
            onTap: () => _getProfilePage(context),
            child: Padding(
              padding: const EdgeInsets.only(top:0.0),
              child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                  height: 100, 
                
                  ),
            ),
          ) : SizedBox(height: 400,),
          ),
         if(AuthService.currentUser != null)
          Center(child: Padding(
                    padding: const EdgeInsets.only(bottom:15.0),
                    child: Text(currentUser.email, style: TextStyle(fontSize: 15, color: Colors.grey),),
                  )),
          HomeMenuOption("Home", Icons.home, () => _getHomePage(context)),
          HomeMenuOption("Friends", Icons.person, () => _getFriendsPage(context)),
          HomeMenuOption("Saved Posts", Icons.bookmark, () => _getFavoritesPage(context)),
          HomeMenuOption("Forums", Icons.chat_bubble_outline_sharp, () => _getForumsPage(context)),
          Container(margin: EdgeInsets.only(top:5, bottom: 10),height: 1, width: MediaQuery.of(context).size.width, decoration: BoxDecoration(color: CustomColors.lightGrey1),),
          //HomeMenuOption("Logout", Icons.logout, () => _logOut(context)),
          AuthService.currentUser != null ? CustomButton(CustomColors.mainYellow, "Log out", () => _logOut(context)) : 
          CustomButton(CustomColors.mainYellow, "Log in", () => _logIn(context)),
          if(AuthService.currentUser == null)
          CustomButton(Colors.orange, "Sign up", () => _signUp(context)),
        ],
      ),
    );
  }
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
