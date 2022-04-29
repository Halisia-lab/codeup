import 'package:codeup/common/custom_colors.dart';
import 'package:flutter/material.dart';

class HomePostAction extends StatelessWidget {
  final IconData icon;
  final String text;
  final action;
  const HomePostAction(this.icon, this.text, this.action);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.action,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:5.0),
                  child: Icon(
                    this.icon,
                    color: CustomColors.lightGrey1,
                  ),
                ),
                Text(
                  this.text,
                  style: TextStyle(color: CustomColors.lightGrey1),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
