import './colors.dart';
import 'package:flutter/material.dart';

class SettingPageStyles {
  // Color backgroundColor = Theme.of(context).
  static TextStyle title = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: "SFPro",
  );
  static TextStyle username = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: SettingPageColors.textColor,
    fontFamily: "SFPro",
  );

  static TextStyle listText = TextStyle(
    fontSize: 17,
    color: SettingPageColors.textColor,
    fontWeight: FontWeight.w700,
    fontFamily: "SFPro",
  );

  static TextStyle subTitle = TextStyle(
    fontSize: 14,
    color: SettingPageColors.subTitle,
    fontWeight: FontWeight.w400,
    fontFamily: "SFPro",
  );
}
