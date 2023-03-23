import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/SplashPage/splash_page.dart';
import 'package:allger/Route/route_generator.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Provider/app_provider.dart';
import 'Provider/auth_provider.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Allergy-G',
        theme: ThemeData(
          fontFamily: 'SFPro',
          primaryColor: Color(0xfffcc18e),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              elevation: 0, foregroundColor: Colors.white),
          brightness: Brightness.light,
          accentColor: Color(0xfffffde9),
          dividerColor: Colors.black.withOpacity(0.1),
          focusColor: Colors.black.withOpacity(1),
          hintColor: Colors.black.withOpacity(0.2),
          // cardColor: Color(0xFFCEAD81),
          primaryColorDark: Color(0xFFCEAD81),
          textTheme: TextTheme(
            headline5:
                TextStyle(fontSize: 22.0, color: Colors.black, height: 1.3),
            headline4: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.3),
            headline3: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            headline1: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                height: 1.4),
            subtitle1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.3),
            headline6: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.3),
            bodyText2: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.2),
            bodyText1: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.3),
            caption: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.black.withOpacity(0.5),
                height: 1.2),
          ),
        ),
        home: Splash(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
