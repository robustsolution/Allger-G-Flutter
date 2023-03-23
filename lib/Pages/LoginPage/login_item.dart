import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:flutter/material.dart';

Widget loginItem({
  required String img,
  required Function onTap,
}) {
  return Container(
    height: 54,
    decoration: const BoxDecoration(
        color: Colors.white,
        // border: Border.all(
        //   color: ,
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0xFFB7C1DF),
              offset: Offset(0.0, 4.0),
              blurRadius: 3.0,
              spreadRadius: 1.0)
        ]),
    child: TouchEffect(
      onTap: () {
        onTap();
      },
      child: Center(
        child: Image(
          image: AssetImage(img),
        ),
      ),
    ),
  );
}
