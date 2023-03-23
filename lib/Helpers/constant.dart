import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LanguagePage/languageItem.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class Constant {
  static String app_base_url = "http://within.id8tr.com";
  // static String app_base_url = "http://10.10.12.134";

  static String english = LocaleKeys.languagePage_english.tr();
  static String hebrew = LocaleKeys.languagePage_hebrew.tr();
  static String french = LocaleKeys.languagePage_french.tr();
  static String german = LocaleKeys.languagePage_german.tr();
  static List<LangItem> langList = [
    LangItem(AppStrings.enFlag, english, Locale('en', 'US')),
    LangItem(AppStrings.isFlag, hebrew, Locale('il', 'IL')),
    LangItem(AppStrings.frFlag, french, Locale('fr', 'FR')),
    LangItem(AppStrings.grFlag, german, Locale('de', 'DE')),
  ];
}

enum LoginType {
  email,

  google,

  facebook,
}
