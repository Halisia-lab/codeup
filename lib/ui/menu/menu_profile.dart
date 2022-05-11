import 'package:codeup/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../common/custom_colors.dart';
import '../common/test_data.dart';

class MenuProfile extends StatelessWidget {
  const MenuProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(Icons.person_rounded, size: 80, color: Colors.black,), onPressed: () => print("cc"));
   
  }

  
}
