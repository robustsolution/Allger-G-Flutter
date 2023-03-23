import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Helpers/constant.dart';
import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/app_provider.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/NotificationPage/Styles/colors.dart';
import 'package:allger/Pages/NotificationPage/Styles/index.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NotificationPage extends StatefulWidget {
  // final String title;

  // NotificationPage({Key? key, required this.title}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _allowNotification = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<void> getNotificationStatus() async {
    if (await Permission.notification.isGranted) {
      // Either the permission was already granted before or the user just granted it.
      setState(() {
        _allowNotification = true;
      });
    } else {
      setState(() {
        _allowNotification = false;
      });
    }
  }

  Future<void> reqNotificationPermission(isActive) async {
    if (isActive) {
      final status = await Permission.notification.request();
      switch (status) {
        case PermissionStatus.denied:
          setState(() {
            _allowNotification = false;
          });
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              // message: LocaleKeys.loginPage_wrongpass.tr(),
              message: "Notification denined!",
            ),
          );
          return;
        case PermissionStatus.granted:
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              // message: LocaleKeys.loginPage_wrongpass.tr(),
              message: "Notification Allowed!",
            ),
          );
          setState(() {
            _allowNotification = true;
          });
          return;
        case PermissionStatus.limited:
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              // message: LocaleKeys.loginPage_wrongpass.tr(),
              message: "Notification limited!",
            ),
          );
          setState(() {
            _allowNotification = false;
          });
          return;
        default:
          setState(() {
            _allowNotification = false;
          });
          return;
      }
    } else {
      // PermissionStatus.denied;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String
    String title = LocaleKeys.notificationPage_title.tr();
    String allowLocation = LocaleKeys.notificationPage_allowNotification.tr();

    // -------------------------------------------------------------------
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    double statusH = MediaQuery.of(context).viewPadding.top;
    UserModel _userModel = AuthProvider.of(context).userModel;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title,
          style: NotificationPageStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - statusH,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Allow Location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: NotificationPageColors.iconBackColor,
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
                        AllerG.bell,
                        size: 20,
                        color: NotificationPageColors.iconColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        allowLocation,
                        style: NotificationPageStyles.langText,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Switch(
                      activeColor: NotificationPageColors.allowSwitchColor,
                      value: _allowNotification,
                      onChanged: (value) async {
                        setState(() {
                          _allowNotification = value;
                        });
                        await reqNotificationPermission(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
