import './colors.dart';
import 'package:flutter/material.dart';

class PersonalPageStyles {
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
    color: PersonalPageColors.textColor,
    fontFamily: "SFPro",
  );

  static TextStyle inputText = TextStyle(
    fontSize: 17,
    color: PersonalPageColors.textColor,
    // fontWeight: FontWeight.bold,
    fontFamily: "SFPro",
  );
}
