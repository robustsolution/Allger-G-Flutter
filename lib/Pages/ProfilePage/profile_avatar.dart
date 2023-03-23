import 'dart:async';
import 'dart:convert';

import 'package:allger/Models/index.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Pages/ProfilePage/Styles/colors.dart';
import 'package:allger/Pages/ProfilePage/Styles/styles.dart';
import 'package:allger/Route/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatefulWidget {
  // Function onTap;
  // String title;

  // ProfileAvatar({Key? key, required this.title, required this.onTap})
  //     : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    UserModel _userModel = AuthProvider.of(context).userModel;

    return Container(
      height: 135,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.0, 1.0],
          colors: ProfilePageColors.avatarBackGradient,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: ProfilePageColors.iconColor,
              image: (_userModel.avatar != "" && _userModel.avatar != null)
                  ? DecorationImage(
                      image: NetworkImage(_userModel.avatar),
                      fit: BoxFit.fill,
                    )
                  : DecorationImage(
                      image: AssetImage(AppStrings.defaultAvatar),
                      fit: BoxFit.fill,
                    ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: ProfilePageColors.iconColor,
              ),
            ),
          ),
          // Image(
          //   image: AssetImage("lib/Assets/Images/user_photo.png"),
          // ),
          SizedBox(
            width: 10,
          ),
          Text(
            "${_userModel.fullname}",
            style: ProfilePageStyles.username,
          ),
        ],
      ),
    );
  }
}
