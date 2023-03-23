import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

const List<Color> _kDefaultRainbowColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String title) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.white,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  // height: 400,
                  width: 80,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: const LoadingIndicator(
                          indicatorType: Indicator.ballRotateChase,

                          /// Required, The loading type of the widget
                          colors: _kDefaultRainbowColors,

                          /// Optional, The color collections
                          strokeWidth: 4,

                          /// Optional, The stroke of the line, only applicable to widget which contains line
                          // backgroundColor: Colors.black,

                          /// Optional, Background of the widget
                          // pathBackgroundColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Please wait..."),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> showLoadingDarkDialog(
      BuildContext context, GlobalKey key, String title) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Theme.of(context).primaryColor,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          title,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }

  // Loading Progressbar Dialog
  static Future<void> showProgressBarDialog(
      BuildContext context, GlobalKey key, String title) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          title,
                          style: TextStyle(color: Colors.black),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
