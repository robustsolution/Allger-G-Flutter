import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Pages/HelpPage/hep_item.dart';
import 'package:allger/Repositories/index.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/dialog.dart';
import 'package:allger/Widgets/main_button.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  int _index = 0;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initializeFirebase();
  }

  // ------ Click Next Button -------
  void onNext() async {
    _index++;
    if (_index > 2) {
      //------- GO TO NEXT PAGE ----------

      await onNextPage();
      // Navigator.pushReplacementNamed(context, Routes.login);
    } else {
      setState(() {
        if (controller.hasClients) {
          print(_index);
          controller.animateToPage(
            _index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Future<void> onNextPage() async {
    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");

    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      // signed in
      print("Logined!=======================");
      try {
        final result = await UserRepository.getUserByID(user.uid);

        if (result != null) {
          UserModel _userModel = UserModel.fromJson(result);
          _userModel.getEmergencyNumbers(result);
          AuthProvider.of(context).setUserModel(_userModel);
          //------------ Dismiss Porgress Dialog  -------------------
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
          Navigator.pushReplacementNamed(context, Routes.profile);
        } else {
          //------------ Dismiss Porgress Dialog  -------------------
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      } catch (e) {
        //------------ Dismiss Porgress Dialog  -------------------
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    } else {
      //------------ Dismiss Porgress Dialog  -------------------
      if (_keyLoader.currentContext != null) {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      }
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  // On Swipe Screen
  void onPageChange(index) {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    var statusHeight = MediaQuery.of(context).viewPadding.top;
    var height = MediaQuery.of(context).size.height - statusHeight;

    List<String> headTitle = [
      LocaleKeys.helpPage_title1.tr(),
      LocaleKeys.helpPage_title2.tr(),
      LocaleKeys.helpPage_title3.tr(),
    ];

    List<String> subTitle = [
      LocaleKeys.helpPage_subTitle1.tr(),
      LocaleKeys.helpPage_subTitle1.tr(),
      LocaleKeys.helpPage_subTitle1.tr(),
    ];

    String continueBtn = LocaleKeys.helpPage_continueBtn.tr();
    String skipBtn = LocaleKeys.helpPage_skipBtn.tr();
    final items = List.generate(
      3,
      (index) => helpItem(
        context: context,
        img: HelpPageStrings.img[index],
        headTxt: headTitle[index],
        subTxt: subTitle[index],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: (MediaQuery.of(context).size.width - 48) + 190,
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (index) async {
                      if (index > 2) {
                        _index = 2;
                        await onNextPage();
                        // Navigator.pushReplacementNamed(context, Routes.login);
                      } else {
                        _index = index;
                      }
                    },
                    // itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return items[index % items.length];
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      SmoothPageIndicator(
                        controller: controller,
                        count: items.length,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: HelpPageColors.activeColor,
                          dotColor: HelpPageColors.disabelDotColor,
                          type: WormType.normal,
                          // strokeWidth: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      MainButton(
                        title: continueBtn,
                        onTap: () => onNext(),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          //------- GO TO NEXT PAGE ----------
                          onNextPage();
                          // Navigator.pushNamed(context, Routes.language,
                          // arguments: "Language");
                        },
                        child: Text(
                          skipBtn,
                          textAlign: TextAlign.center,
                          style: HelpPageStyles.skipBtnTxt,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
