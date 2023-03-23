import './colors.dart';
import 'package:flutter/material.dart';

class HelpPageStyles {
  // Color backgroundColor = Theme.of(context).
  static TextStyle headTxt = TextStyle(
    color: HelpPageColors.txtColor,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
  );
  static TextStyle subTxt = TextStyle(
    fontSize: 17,
    color: HelpPageColors.txtColor,
    fontFamily: "SFPro",
  );

  static TextStyle continueBtnTxt = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: Colors.white,
  );

  static TextStyle skipBtnTxt = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: HelpPageColors.activeColor,
  );
}
