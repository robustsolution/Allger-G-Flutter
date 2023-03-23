import './colors.dart';
import 'package:flutter/material.dart';

class SignupPageStyles {
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
    color: SignupPageColors.strongColor,
    fontFamily: "SFPro",
  );

  static TextStyle hint = TextStyle(
    fontSize: 17,
    color: SignupPageColors.greyColor,
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
    color: SignupPageColors.txtColor,
  );

  static TextStyle regEmail = TextStyle(
    fontSize: 16,
    fontFamily: "SFPro",
    fontWeight: FontWeight.w400,
    color: SignupPageColors.txtColor,
  );

  static TextStyle dontAccount = TextStyle(
    fontSize: 16,
    fontFamily: "SFPro",
    fontWeight: FontWeight.bold,
    color: SignupPageColors.txtColor,
  );

  static TextStyle signupBtnTxt = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: SignupPageColors.activeColor,
  );

  static TextStyle forgotBtnTxt = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
    color: SignupPageColors.activeColor,
  );

  static TextStyle inputTxt = TextStyle(
    fontSize: 17,
    fontFamily: "SFPro",
    color: SignupPageColors.strongColor,
  );
}
