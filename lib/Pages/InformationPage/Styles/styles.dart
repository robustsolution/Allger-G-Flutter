import './colors.dart';
import 'package:flutter/material.dart';

class InformationPageStyles {
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
    color: InformationPageColors.textColor,
    fontFamily: "SFPro",
  );

  static TextStyle inputTxt = TextStyle(
    fontSize: 17,
    color: InformationPageColors.inputTxtColor,
    // fontWeight: FontWeight.w700,
    fontFamily: "SFPro",
  );

  static TextStyle allergyBtn = TextStyle(
    fontSize: 17,
    color: InformationPageColors.mainColor,
    fontWeight: FontWeight.w400,
    fontFamily: "SFPro",
  );

  // static TextStyle takePhotoTxt = TextStyle(
  //   fontSize: 20,
  //   color: InformationPageColors.mainColor,
  //   fontWeight: FontWeight.w400,
  //   fontFamily: "SFPro",
  // );
}
