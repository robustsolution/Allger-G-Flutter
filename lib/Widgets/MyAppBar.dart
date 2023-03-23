import 'dart:async';
import 'dart:convert';

import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatefulWidget {
  Widget back;
  Widget action;
  Widget title;

  MyAppBar({
    Key? key,
    required this.back,
    required this.action,
    required this.title,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      // statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return SizedBox(
      height: 30.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[widget.back, widget.title, widget.action],
        ),
      ),
    );
  }
}
