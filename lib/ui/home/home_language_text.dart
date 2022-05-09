import '../common/custom_colors.dart';
import '../common/language_enum.dart';
import 'package:flutter/material.dart';

class HomeLanguageText extends StatelessWidget {
  final LanguageValue languageValue;
  const HomeLanguageText(this.languageValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(LanguageEnum.getValue(languageValue), style: TextStyle(fontSize: 13, color: Colors.white),),
        ),
        decoration: BoxDecoration(
            color: CustomColors.mainYellow, borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
