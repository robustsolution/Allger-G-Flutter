import 'package:allger/Helpers/index.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:flutter/material.dart';

Widget FloatingButton() {
  return FloatingActionButton(
    onPressed: () {
      // Add your onPressed code here!
    },
    backgroundColor: Colors.greenAccent,
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.0, 1.0],
          colors: AppColors.floatingBtnGradient,
        ),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(AllerG.attention),
          Text(
            "SOS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          )
        ],
      ),
    ),
  );
}
