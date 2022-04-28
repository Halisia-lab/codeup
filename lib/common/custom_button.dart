import 'package:codeup/common/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final color, text, action;
  const CustomButton(this.color, this.text, this.action);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:20.0, left: 20),
      child: ElevatedButton(onPressed: this.action, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(this.color) ), child: Text(this.text, style: TextStyle(color: CustomColors.white),)),
    );
  }
}