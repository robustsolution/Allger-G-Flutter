import './colors.dart';
import 'package:flutter/material.dart';

class UploadPhotoPageStyles {
  // Color backgroundColor = Theme.of(context).
  static TextStyle title = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: "SFPro",
  );
  static TextStyle header = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: UploadPhotoPageColors.headerColor,
    fontFamily: "SFPro",
  );

  static TextStyle subText = TextStyle(
    fontSize: 17,
    color: UploadPhotoPageColors.subColor,
    // fontWeight: FontWeight.w700,
    fontFamily: "SFPro",
  );

  static TextStyle orText = TextStyle(
    fontSize: 17,
    color: UploadPhotoPageColors.orColor,
    // fontWeight: FontWeight.w700,
    fontFamily: "SFPro",
  );

  static TextStyle takePhotoTxt = TextStyle(
    fontSize: 20,
    color: UploadPhotoPageColors.mainColor,
    fontWeight: FontWeight.w400,
    fontFamily: "SFPro",
  );
}
