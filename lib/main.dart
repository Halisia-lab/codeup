import 'package:codeup/entities/Person.dart';
import 'package:codeup/ui/authentication/sign_in/sign_in_screen.dart';
import 'package:codeup/ui/comment/comment_list_screen.dart';
import 'package:codeup/ui/common/test_data.dart';
import 'package:codeup/ui/home/home_screen.dart';
import 'package:codeup/ui/common/custom_colors.dart';
import 'package:flutter/material.dart';

import 'ui/authentication/sign_up/sign_up_screen.dart';
import 'ui/forums/forum_page/forum_page_screen.dart';
import 'ui/forums/forums_screen.dart';
import 'ui/friends/friends_screen.dart';
import 'ui/profile/profile_screen.dart';
import 'ui/saved_posts/saved_posts_screen.dart';
import 'ui/search/search_screen.dart';

void main() {
  runApp(MyApp("sign-in"));
}

class MyApp extends StatelessWidget {
  final String launchRoute;
  Person currentUser = TestData.currentUser;

  MyApp(this.launchRoute);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CodeUp',
        theme: ThemeData(
          
          primarySwatch: CustomColors.darkText,
          secondaryHeaderColor: CustomColors.mainYellow,
        ),
        home: const HomeScreen(),
        initialRoute: launchRoute,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          ForumsScreen.routeName: (ctx) => ForumsScreen(),
          FriendsScreen.routeName: (ctx) => FriendsScreen(),
          SavedPostsScreen.routeName: (ctx) => SavedPostsScreen(),
          ForumPageScreen.routeName: (ctx) => ForumPageScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(currentUser),
          //CommentList.routeName: (ctx) => ProfileScreen(currentUser),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
