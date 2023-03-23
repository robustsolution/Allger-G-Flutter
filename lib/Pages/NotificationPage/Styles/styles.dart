import './colors.dart';
import 'package:flutter/material.dart';

class NotificationPageStyles {
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
    color: NotificationPageColors.textColor,
    fontFamily: "SFPro",
  );

  static TextStyle langText = TextStyle(
    fontSize: 17,
    color: NotificationPageColors.textColor,
    fontWeight: FontWeight.w500,
    fontFamily: "SFPro",
  );
}
