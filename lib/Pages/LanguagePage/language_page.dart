import 'package:allger/Helpers/constant.dart';
import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/app_provider.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LanguagePage/Styles/index.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'languageItem.dart';

class LanguagePage extends StatefulWidget {
  // final String title;

  // LanguagePage({Key? key, required this.title}) : super(key: key);
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  TextEditingController usernameCtl = new TextEditingController();
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  TextEditingController rpasswordCtl = new TextEditingController();

  // String initialCountry = Countries.countyNames[0].toString().toUpperCase();
  // PhoneNumber number = PhoneNumber(isoCode: 'UA');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      usernameCtl.text = "";
      emailCtl.text = "";
      passwordCtl.text = "";
      rpasswordCtl.text = "";
      // context.setLocale(context.supportedLocales[0]);
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));
  }

  @override
  void didUpdateWidget(covariant LanguagePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FocusScope.of(context).requestFocus(new FocusNode());
  }

  // Change Language
  Future<void> changeLang(LangItem lang) async {
    // Set Current Language
    AppProvider.of(context).setCurrentLang(lang);
    print("Language Changed successfully!");
    // context.supportedLocales[1];
    context.locale = Locale('en', 'US');
    await context.setLocale(lang.local);
    // Navigator.pop(context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // String
    String title = LocaleKeys.languagePage_title.tr();
    String selectedLang = LocaleKeys.languagePage_selectedLang.tr();
    String selectLang = LocaleKeys.languagePage_selectLang.tr();

    // -------------------------------------------------------------------
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    double statusH = MediaQuery.of(context).viewPadding.top;
    UserModel _userModel = AuthProvider.of(context).userModel;

    // Get Current Langlist;
    LangItem currentLang = AppProvider.of(context).currentLang;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title,
          style: LanguagePageStyles.title,
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
                // Selected Langauge
                Text(
                  selectedLang,
                  style: LanguagePageStyles.text,
                ),

                languageList(
                  onTap: () {},
                  lang: currentLang,
                  fillColor: LanguagePageColors.fillColor,
                ),
                const SizedBox(height: 47),
                Container(
                  margin: const EdgeInsets.only(top: 47),
                  child: Text(
                    selectLang,
                    style: LanguagePageStyles.text,
                  ),
                ),
                Column(
                  children: Constant.langList.map((lang) {
                    return (lang.lang != currentLang.lang)
                        ? languageList(
                            onTap: (LangItem value) async {
                              await changeLang(value);
                            },
                            lang: lang,
                          )
                        : Container();
                  }).toList(),
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
