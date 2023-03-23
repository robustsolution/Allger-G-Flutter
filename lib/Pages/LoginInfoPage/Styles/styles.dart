import './colors.dart';
import 'package:flutter/material.dart';

class LoginInfoPageStyles {
  // Color backgroundColor = Theme.of(context).
  static TextStyle title = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: "SFPro",
  );
  static TextStyle text = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: LoginInfoPageColors.textColor,
    fontFamily: "SFPro",
  );

  static TextStyle inputText = TextStyle(
    fontSize: 17,
    color: LoginInfoPageColors.textColor,
    fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
  );
}
