import 'package:allger/Pages/HelpPage/help_page.dart';
import 'package:allger/Pages/InformationPage/informationPage.dart';
import 'package:allger/Pages/LanguagePage/language_page.dart';
import 'package:allger/Pages/LocationPage/location_page.dart';
import 'package:allger/Pages/LoginInfoPage/loginInfo_page.dart';
import 'package:allger/Pages/LoginPage/login_page.dart';
import 'package:allger/Pages/NotificationPage/notification_page.dart';
import 'package:allger/Pages/PersonalPage/personal_page.dart';
import 'package:allger/Pages/ProfilePage/profile_page.dart';
import 'package:allger/Pages/SettingPage/setting_page.dart';
import 'package:allger/Pages/SignupPage/signup_page.dart';
import 'package:allger/Pages/SplashPage/splash_page.dart';
import 'package:allger/Pages/UploadPhotoPage/upload_photo_page.dart';
import 'package:flutter/material.dart';

import 'routes.dart';
// import 'package:flutternavigationsample/first_screen.dart';
// import 'package:flutternavigationsample/second_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => Splash());
      case Routes.help:
        return MaterialPageRoute(builder: (_) => HelpPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case Routes.personalData:
        return MaterialPageRoute(builder: (_) => PersonalPage());
      case Routes.uploadPhoto:
        return MaterialPageRoute(builder: (_) => UploadPhotoPage());
      case Routes.information:
        return MaterialPageRoute(builder: (_) => InformationPage());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case Routes.loginInfo:
        return MaterialPageRoute(builder: (_) => LoginInfoPage());
      case Routes.language:
        return MaterialPageRoute(builder: (_) => LanguagePage());
      case Routes.notification:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case Routes.location:
        return MaterialPageRoute(builder: (_) => LocationPage());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
