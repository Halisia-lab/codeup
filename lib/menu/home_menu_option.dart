import 'package:flutter/material.dart';

class HomeMenuOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final action;
  const HomeMenuOption(this.text, this.icon, this.action);

  @override
  Widget build(BuildContext context) {
     return Center(
       child: ListTile(
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(this.icon),
                  ),
                  Text(this.text),
                ],
              ),
              onTap: this.action,
            ),
     );
  }
}