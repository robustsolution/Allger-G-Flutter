import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Helpers/constant.dart';
import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/app_provider.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LocationPage/Styles/colors.dart';
import 'package:allger/Pages/LocationPage/Styles/index.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/services.dart';

class LocationPage extends StatefulWidget {
  // final String title;

  // LocationPage({Key? key, required this.title}) : super(key: key);
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _allowLocation = false;
  String address = "";
  bool isLoad = true;

  List<Color> _kDefaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermissionStatus();
    getAddress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  Future<void> getAddress() async {
    String error;

    try {
      Position position = await _getGeoLocationPosition();
      String addr = await GetAddressFromLatLong(position);
      setState(() {
        address = addr;
      });
    } catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          // message: LocaleKeys.loginPage_wrongpass.tr(),
          message: e.toString(),
        ),
      );
    }

    setState(() {
      isLoad = false;
    });
  }

  // Get Permissions
  Future<void> getPermissionStatus() async {
    if (await Permission.location.isGranted) {
      setState(() {
        _allowLocation = true;
      });
    } else {
      setState(() {
        _allowLocation = false;
      });
    }
  }

  // Request Permissions

  Future<void> requestPerssion(isActive) async {
    if (isActive) {
      bool status1 = await Permission.location.request().isGranted;

      // bool status2 = await Permission.locationAlways.request().isGranted;
      // Map<Permission, PermissionStatus> statuses = await [
      //   Permission.location,
      //   Permission.locationAlways,
      //   Permission.locationWhenInUse,
      // ].request();

      await getPermissionStatus();

      if (_allowLocation) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            // message: LocaleKeys.loginPage_wrongpass.tr(),
            message: "Location access granted!",
          ),
        );
      } else {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            // message: LocaleKeys.loginPage_wrongpass.tr(),
            message: "Notification denined!",
          ),
        );
      }
    } else {
      // PermissionStatus.denied;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String
    String title = LocaleKeys.locationPage_title.tr();
    String allowLocation = LocaleKeys.locationPage_allowLocation.tr();
    String myLocation = LocaleKeys.locationPage_myLocation.tr();

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title,
          style: LocationPageStyles.title,
        ),
      ),
      body: SafeArea(
        child: (isLoad)
            ? Center(
                child: Container(
                  color: Colors.white,
                  width: 60,
                  child: LoadingIndicator(
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
              )
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - statusH,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
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
                              color: LocationPageColors.iconBackColor,
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
                              AllerG.paper_plane,
                              size: 20,
                              color: LocationPageColors.iconColor,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              allowLocation,
                              style: LocationPageStyles.langText,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Switch(
                            activeColor: LocationPageColors.allowSwitchColor,
                            value: _allowLocation,
                            onChanged: (value) async {
                              setState(() {
                                _allowLocation = value;
                              });
                              await requestPerssion(value);
                            },
                          ),
                        ],
                      ),

                      // Your Location
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                        decoration: BoxDecoration(
                          color: LocationPageColors.locationBackColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          address,
                          style: LocationPageStyles.langText,
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
