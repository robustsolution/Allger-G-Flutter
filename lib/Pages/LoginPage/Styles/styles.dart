import './colors.dart';
import 'package:flutter/material.dart';

class LoginPageStyles {
  // Color backgroundColor = Theme.of(context).
  static TextStyle title = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: "SFPro",
  );
  static TextStyle title1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: LoginPageColors.strongColor,
    fontFamily: "SFPro",
  );

  static TextStyle hint = TextStyle(
    fontSize: 17,
    color: LoginPageColors.greyColor,
    fontFamily: "SFPro",
  );

  static TextStyle loginBtnTxt = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: Colors.white,
  );

  static TextStyle loginWith = TextStyle(
    fontSize: 17,
    fontFamily: "SFPro",
    fontWeight: FontWeight.bold,
    color: LoginPageColors.txtColor,
  );

  static TextStyle dontAccount = TextStyle(
    fontSize: 14,
    fontFamily: "SFPro",
    color: LoginPageColors.txtColor,
  );

  static TextStyle signupBtnTxt = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: LoginPageColors.activeColor,
  );

  static TextStyle forgotBtnTxt = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: LoginPageColors.activeColor,
  );

  static TextStyle inputTxt = TextStyle(
    fontSize: 17,
    fontFamily: "SFPro",
    color: LoginPageColors.strongColor,
  );
}
