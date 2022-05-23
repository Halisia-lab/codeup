import 'package:codeup/ui/common/custom_button.dart';
import 'package:codeup/ui/common/custom_colors.dart';
import 'package:codeup/ui/component/adaptive_button.dart';
import 'package:codeup/ui/forums/forum_list_item.dart';
import 'package:flutter/material.dart';

class ForumJoinButton extends StatelessWidget {
  const ForumJoinButton();

  @override
  Widget build(BuildContext context) {
    return 
         CustomButton(CustomColors.mainYellow, "Join", () => _joinForum());
  }

  _joinForum() {
    
  }
}
