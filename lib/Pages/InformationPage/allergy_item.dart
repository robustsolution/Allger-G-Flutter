import 'dart:async';
import 'dart:convert';

import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Pages/InformationPage/Styles/index.dart';
import 'package:allger/Pages/InformationPage/informationPage.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllergyItem extends StatefulWidget {
  Function onTap;
  String title;
  Image? icon;
  bool? active;

  AllergyItem(
      {Key? key,
      required this.onTap,
      required this.title,
      this.icon,
      this.active})
      : super(key: key);

  @override
  _AllergyItemState createState() => _AllergyItemState();
}

class _AllergyItemState extends State<AllergyItem> {
  bool isActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isActive = widget.active ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TouchEffect(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
        widget.onTap(isActive, widget.title);
      },
      child: Container(
        height: 46,
        // width: 100,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isActive ? InformationPageColors.fillColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: InformationPageColors.mainColor,
          ),
        ),
        child: Row(
          children: <Widget>[
            widget.icon!,
            SizedBox(
              width: 10,
            ),
            Text(
              widget.title,
            )
          ],
        ),
      ),
    );
  }
}
