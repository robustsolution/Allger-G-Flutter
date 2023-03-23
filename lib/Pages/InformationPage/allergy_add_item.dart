import 'dart:async';
import 'dart:convert';

import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Pages/InformationPage/Styles/index.dart';
import 'package:allger/Pages/InformationPage/informationPage.dart';
import 'package:allger/Route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllergyAddItem extends StatefulWidget {
  Function onTap;

  AllergyAddItem({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _AllergyAddItemState createState() => _AllergyAddItemState();
}

class _AllergyAddItemState extends State<AllergyAddItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 46,
      // width: 100,
      // margin: EdgeInsets.only(right: 10),
      // padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: InformationPageColors.mainColor,
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                widget.onTap();
              },
              icon: Icon(
                Icons.add,
                color: InformationPageColors.mainColor,
                // size: 25,
              ),
            ),
          ]),
    );
  }
}
