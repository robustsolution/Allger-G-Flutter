import './colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // Color backgroundColor = Theme.of(context).
  TextStyle errorTxt = TextStyle(
    color: AppColors.errorTxtColor,
    fontSize: 16,
  );
  TextStyle sourceTxt = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.greenAccent[400],
  );

  TextStyle dateTxt = TextStyle(
    color: Colors.red,
    fontSize: 12,
  );

  static TextStyle menuTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontFamily: "SFPro",
  );

  bool darkTheme = false;
}
