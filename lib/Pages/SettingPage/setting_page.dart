import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Models/index.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/SettingPage/Styles/index.dart';
import 'package:allger/Pages/SettingPage/setting_list_item.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/FloatingButton.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class SettingPage extends StatefulWidget {
  // final String title;

  // SettingPage({Key? key, required this.title}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController usernameCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      usernameCtl.text = "";
      passwordCtl.text = "";
    });
  }

  @override
  void didUpdateWidget(covariant SettingPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    // Settings
    String title = LocaleKeys.settingPage_title.tr();
    String loginInfo = LocaleKeys.settingPage_loginInfo.tr();
    String language = LocaleKeys.settingPage_language.tr();
    String notification = LocaleKeys.settingPage_notification.tr();
    String location = LocaleKeys.settingPage_location.tr();
    String help = LocaleKeys.settingPage_help.tr();
    //-------------------------------------------------------------
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
          style: SettingPageStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - statusH,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      SettingListItem(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.loginInfo);
                          },
                          title: loginInfo,
                          icon: Icons.email,
                          suffIcon: true),
                      SettingListItem(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.language);
                        },
                        title: language,
                        icon: Icons.translate,
                        suffIcon: true,
                        subTitle: "English",
                      ),
                      SettingListItem(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.notification);
                          },
                          title: notification,
                          icon: AllerG.bell,
                          suffIcon: true),
                      // Divider(),
                      SettingListItem(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.location);
                          },
                          title: location,
                          icon: AllerG.location_inv,
                          suffIcon: true),

                      SettingListItem(
                          onTap: () {
                            print("FSDFSD");
                          },
                          title: help,
                          icon: AllerG.lamp,
                          suffIcon: true),
                    ],
                  ),
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
