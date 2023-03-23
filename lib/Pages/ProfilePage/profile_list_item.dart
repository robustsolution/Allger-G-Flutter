import 'package:allger/Helpers/index.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:flutter/material.dart';

import 'Styles/index.dart';

Widget ProfileListItem({
  required Function onTap,
  required IconData icon,
  required String title,
  required bool suffIcon,
}) {
  return TouchEffect(
    onTap: () {
      onTap();
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: ProfilePageColors.iconBackColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(183, 193, 223, 0.5),
                  offset: Offset(2.0, 3.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0)
            ],
          ),
          child: Icon(
            icon,
            size: 20,
            color: ProfilePageColors.iconColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            title,
            style: ProfilePageStyles.listText,
          ),
        ),
        (suffIcon)
            ? Container(
                margin: const EdgeInsets.only(top: 10),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: ProfilePageColors.iconBackColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: ProfilePageColors.arrowColor,
                    size: 12,
                  ),
                  onPressed: () {
                    onTap();
                  },
                ),
              )
            : Container(),
      ],
    ),
  );
}
