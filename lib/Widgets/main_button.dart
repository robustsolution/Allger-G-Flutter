import 'dart:async';
import 'dart:convert';

import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  Function onTap;
  String title;

  MainButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  _MainButtonState createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.0, 1.0],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0xFFB5CFFF),
              Color(0xFF7E9DFE),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xFF7E9DFE),
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 1.0)
          ],
        ),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                  child:
                      Text(widget.title, style: HelpPageStyles.continueBtnTxt),
                )),
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () => widget.onTap()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
