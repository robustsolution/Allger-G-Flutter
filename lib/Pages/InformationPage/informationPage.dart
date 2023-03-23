import 'dart:io';

import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Models/index.dart';
import 'package:allger/Pages/App/Provider/app_provider.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/InformationPage/allergy_add_item.dart';
import 'package:allger/Pages/InformationPage/allergy_item.dart';
import 'package:allger/Pages/PersonalPage/Styles/strings.dart';
import 'package:allger/Pages/PersonalPage/personal_page.dart';
import 'package:allger/Pages/InformationPage/Styles/index.dart';
import 'package:allger/Repositories/index.dart';
import 'package:allger/Widgets/mydrawer.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/FloatingButton.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class InformationPage extends StatefulWidget {
  // final String title;

  // InformationPage({Key? key, required this.title}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  File? _imageFile;
  String path = "";
  bool isFile = false;
  bool isEpiPen = false;
  bool isChangedEpi = false;
  List<String>? _Allergys;

  String _height = "";
  String _weight = "";
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  UserModel userModel = UserModel();

  /***************************************
   * Update Information
   */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {});
    // getAlleryList();
  }

  //  Get Allergy List

  @override
  void didUpdateWidget(covariant InformationPage oldWidget) {
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

  Future<void> updateInfo(BuildContext context) async {
    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");

    String allergyTypes = "";
    _Allergys!.map((String e) {
      if (e.isNotEmpty) {
        allergyTypes += e.toString();
        if (e != _Allergys!.last) {
          allergyTypes += ",";
        }
      }
    }).toList();

    userModel.allergyTypes = allergyTypes;
    userModel.height = int.parse(_height);
    userModel.weight = int.parse(_weight.replaceAll("Kg", ""));
    userModel.epiPen = isEpiPen ? 1 : 0;
    try {
      await UserRepository.updateUser(userModel);

      AuthProvider.of(context).setUserModel(userModel);
    } on FirebaseException catch (e) {
      print(e);
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: LocaleKeys.error.tr(),
        ),
      );
    } catch (e) {
      print(e);
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: LocaleKeys.error.tr(),
        ),
      );
    }
    //------------ Dismiss Porgress Dialog  -------------------
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: LocaleKeys.success.tr(args: ["Updated"]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    double statusH = MediaQuery.of(context).viewPadding.top;

    // Strings
    String title = LocaleKeys.informationPage_title.tr();
    String type = LocaleKeys.informationPage_type.tr();
    // List<String> allergies = [
    //   LocaleKeys.informationPage_peanut.tr(),
    //   LocaleKeys.informationPage_soy.tr(),
    //   LocaleKeys.informationPage_nuts.tr(),
    //   LocaleKeys.informationPage_legumes.tr(),
    //   LocaleKeys.informationPage_fruit.tr(),
    //   LocaleKeys.informationPage_fish.tr(),
    //   LocaleKeys.informationPage_wheat.tr(),
    //   LocaleKeys.informationPage_milk.tr(),
    //   LocaleKeys.informationPage_eggs.tr(),
    //   LocaleKeys.informationPage_sesame.tr(),
    // ];

    String height = LocaleKeys.informationPage_height.tr();
    String weight = LocaleKeys.informationPage_weight.tr();
    String epiPen = LocaleKeys.informationPage_epiPen.tr();
    String updateBtn = LocaleKeys.personalPage_updateBtn.tr();
    // String error = LocaleKeys.error.tr();
    //-------------------------------------------------------3

    /**************************************
     * Init Values with UserMode;
     */
    userModel = AuthProvider.of(context).userModel;
    _Allergys = _Allergys ?? userModel.allergyTypes.split(',');
    _weight = (_weight == "") ? '${userModel.weight}Kg' : _weight;
    _height = (_height == "") ? '${userModel.height}' : _height;
    isEpiPen = isChangedEpi
        ? isEpiPen
        : (userModel.epiPen == 1)
            ? true
            : false;
    // Allergy Items
    List<Widget> items = List.generate(
      InformationPageStrings.alleryTextList.length,
      (index) => Container(
        width: 60 + InformationPageStrings.alleryTextList[index].length * 13,
        child: AllergyItem(
          onTap: (bool active, String value) {
            if (!active && _Allergys!.contains(value)) {
              _Allergys!.remove(value);
            } else {
              _Allergys!.add(value);
            }
            setState(() {});
          },
          icon: Image(
              image: AssetImage(InformationPageStrings.allergyIcons[index])),
          title: InformationPageStrings.alleryTextList[index],
          active:
              _Allergys!.contains(InformationPageStrings.alleryTextList[index]),
        ),
      ),
    );

    items.add(AllergyAddItem(onTap: () {
      print("FDSFD");
    }));

    //----- Height Items -------------
    List<String> heightItems = List.generate(
      400,
      (index) => '${index + 1}',
    );

    //----- Weight Items
    List<String> weightItems = List.generate(
      400,
      (index) => '${index + 1}Kg',
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title,
          style: InformationPageStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            height: MediaQuery.of(context).size.height - statusH,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      type,
                      style: InformationPageStyles.text,
                    ),
                    const Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 25),
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    // clipBehavior: Clip.hardEdge,
                    children: items.map((box) {
                      return box;
                    }).toList(),
                  ),
                ),

                // Height
                Text(
                  height,
                  style: InformationPageStyles.text,
                ),
                const SizedBox(height: 10),
                DropDownBox(
                  hint: Text(
                    "170",
                    style: InformationPageStyles.inputTxt,
                  ),
                  initValue: _height,
                  textStyle: InformationPageStyles.inputTxt,
                  items: heightItems,
                  activeColor: AppColors.activeColor,
                  normalColor: InformationPageColors.mainColor,
                  onChange: (value) {
                    print(value);
                    setState(() {
                      _height = value;
                    });
                  },
                  validator: (value) {
                    print(value);
                  },
                ),

                // Weight
                const SizedBox(height: 25),
                Text(
                  weight,
                  style: InformationPageStyles.text,
                ),
                const SizedBox(height: 10),
                DropDownBox(
                  hint: Text(
                    "78Kg",
                    style: InformationPageStyles.inputTxt,
                  ),
                  initValue: _weight,
                  textStyle: InformationPageStyles.inputTxt,
                  items: weightItems,
                  activeColor: AppColors.activeColor,
                  normalColor: InformationPageColors.mainColor,
                  onChange: (value) {
                    print(value);
                    setState(() {
                      _weight = value;
                    });
                  },
                  validator: (value) {
                    print(value);
                  },
                ),

                // Epi Pen
                const SizedBox(height: 41),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          epiPen,
                          style: InformationPageStyles.text,
                        ),
                        Text(
                          "*",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                    Switch(
                      activeColor: InformationPageColors.epiPenColor,
                      value: isEpiPen,
                      onChanged: (value) {
                        setState(() {
                          isEpiPen = value;
                          isChangedEpi = true;
                        });
                      },
                    ),
                  ],
                ),
                // Update Button
                const SizedBox(height: 40),
                MainButton(
                    title: updateBtn,
                    onTap: () async {
                      await updateInfo(context);
                      // await uploadImageToFirebase(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
