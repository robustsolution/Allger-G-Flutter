import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:flutter/material.dart';

Widget helpItem(
    {required BuildContext context,
    required String img,
    required String headTxt,
    required String subTxt}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 48,
          height: 280,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          headTxt,
          style: HelpPageStyles.headTxt,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          subTxt,
          textAlign: TextAlign.center,
          style: HelpPageStyles.subTxt,
        ),
      ],
    ),
  );
}
