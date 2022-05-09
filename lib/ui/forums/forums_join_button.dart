import 'package:codeup/ui/common/custom_button.dart';
import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/ui/component/adaptive_button.dart';
import 'package:flutter/material.dart';

class ForumJoinButton extends StatelessWidget {
  const ForumJoinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
         CustomButton(CustomColors.mainYellow, "Join", () => print("join"));
       
      
     /*  ElevatedButton(
      
      child: Container(
        
        child: Text("Join"),
        decoration: BoxDecoration(color: CustomColors.mainYellow),
      ),
      onPressed: () => _joinForum,
    ); */
  }

  _joinForum() {
    print("join forum");
  }
}
