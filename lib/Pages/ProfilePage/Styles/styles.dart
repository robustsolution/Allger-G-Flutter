import './colors.dart';
import 'package:flutter/material.dart';

class ProfilePageStyles {
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
    color: ProfilePageColors.textColor,
    fontFamily: "SFPro",
  );

  static TextStyle listText = TextStyle(
    fontSize: 17,
    color: ProfilePageColors.textColor,
    fontWeight: FontWeight.w700,
    fontFamily: "SFPro",
  );
}
