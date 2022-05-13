import '../common/custom_colors.dart';
import 'package:flutter/material.dart';

class PostBoxAction extends StatelessWidget {
  final IconData icon;
  final String text;
  final action;
  const PostBoxAction(this.icon, this.text, this.action);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:5.0),
                  child: Icon(
                    this.icon,
                    color: CustomColors.darkText,
                  ),
                ),
                Text(
                  this.text,
                  style: TextStyle(color: CustomColors.lightGrey6, fontSize: 15),
                )
              ],
            )
          ],
        ),
      );
  }
}
