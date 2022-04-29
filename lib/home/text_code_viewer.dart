import 'package:codeup/common/custom_colors.dart';
import 'package:flutter/material.dart';

class TextCodeViewer extends StatelessWidget {
  final text;
  const TextCodeViewer(this.text);

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.all(
        2.0,
      ),
      child: Container(
        color: CustomColors.darkText,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: RichText(
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text:this.text,
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
        ),
      ),
    );
  }
}