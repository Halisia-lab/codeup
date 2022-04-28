import 'package:flutter/material.dart';

class HomeMenuProfile extends StatelessWidget {
  const HomeMenuProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.person_rounded, size: 80,), onPressed: () => print('profile page'));
  }
}