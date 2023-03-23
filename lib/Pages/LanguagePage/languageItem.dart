import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LanguagePage/Styles/index.dart';
import 'package:allger/Pages/LanguagePage/language_page.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget languageList({
  required Function onTap,
  required LangItem lang,
  Color? fillColor,
}) {
  return Container(
    height: 54,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: fillColor ?? Colors.transparent,
      border: Border.all(
        width: 1,
        color: LanguagePageColors.iconColor,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: TouchEffect(
      onTap: () {
        onTap(lang);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            // radius: 40,
            backgroundImage: AssetImage(lang.flag),
          ),
          const SizedBox(width: 20),
          Text(
            lang.lang,
            style: LanguagePageStyles.langText,
          ),
        ],
      ),
    ),
  );
}

class LangItem {
  String lang;
  String flag;
  Locale local;

  LangItem(this.flag, this.lang, this.local);
}
