import 'package:codeup/common/custom_colors.dart';
import 'package:codeup/common/language_enum.dart';
import 'package:flutter/material.dart';

class HomeLanguageText extends StatelessWidget {
  final LanguageValue languageValue;
  const HomeLanguageText(this.languageValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(LanguageEnum.getValue(languageValue)),
        ),
        decoration: BoxDecoration(
            color: CustomColors.beige, borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
