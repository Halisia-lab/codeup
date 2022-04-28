import 'package:flutter/material.dart';

import 'components/post_content/text_viewer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          trailing: GestureDetector(
            onTap: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                )),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
          ),
          title: Center(
            child: const Text(
              'SAV REDDIT',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png"),
                ),
              )),
              SizedBox(height: 10),
              const Text(
                'Nom prénom',
                style: TextStyle(
                  height: 5,
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                '1000 pts',
                style: TextStyle(
                  height: 5,
                  color: Colors.blue,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 16),
                  child: Column(
                    children: [
                      TextViewer(
                        'There are two other properties related to size: minRadius and maxRadius. They are used to set the minimum and maximum radius respectively. I',
                      ),
                      TextViewer(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
