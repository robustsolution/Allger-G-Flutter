import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Models/index.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/ProfilePage/Styles/index.dart';
import 'package:allger/Pages/ProfilePage/profile_avatar.dart';
import 'package:allger/Widgets/mydrawer.dart';
import 'package:allger/Pages/ProfilePage/profile_list_item.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/FloatingButton.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
  void didUpdateWidget(covariant ProfilePage oldWidget) {
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

  Future<void> signOut() async {
    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Sign Outing..");
    try {
      await FirebaseAuth.instance.signOut();

      //------------ Dismiss Porgress Dialog  -------------------
      if (_keyLoader != null)
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      //---- Show Error Msg
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: LocaleKeys.error.tr(),
        ),
      );

      //------------ Dismiss Porgress Dialog  -------------------
      if (_keyLoader.currentContext != null)
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Strings
    String title = LocaleKeys.profilePage_title.tr();
    String personal = LocaleKeys.profilePage_personal.tr();
    String allergy = LocaleKeys.profilePage_allergy.tr();
    String setting = LocaleKeys.profilePage_setting.tr();
    String logout = LocaleKeys.profilePage_logout.tr();

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
          style: ProfilePageStyles.title,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
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
                ProfileAvatar(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      ProfileListItem(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.personalData,
                              arguments: personal,
                            );
                          },
                          title: personal,
                          icon: AllerG.user,
                          suffIcon: true),
                      ProfileListItem(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.information,
                              arguments: allergy,
                            );
                          },
                          title: allergy,
                          icon: Icons.info,
                          suffIcon: true),
                      ProfileListItem(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.settings,
                              arguments: setting,
                            );
                          },
                          title: setting,
                          icon: Icons.settings,
                          suffIcon: true),
                      Divider(),
                      ProfileListItem(
                          onTap: () async {
                            await signOut();
                            await GoogleSignIn().signOut();
                          },
                          title: logout,
                          icon: FontAwesomeIcons.signOutAlt,
                          suffIcon: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: myDrawer(context),
      floatingActionButton: FloatingButton(),
    );
  }
}
