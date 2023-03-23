import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Helpers/countries.dart';
import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/PersonalPage/Styles/index.dart';
import 'package:allger/Repositories/user_repository.dart';
import 'package:allger/Widgets/mydrawer.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/FloatingButton.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/Widgets/phonenumberBox.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  TextEditingController firstnameCtl = new TextEditingController();
  TextEditingController lastnameCtl = new TextEditingController();
  TextEditingController phoneCtl = new TextEditingController();
  TextEditingController ephoneCtl = new TextEditingController();
  TextEditingController eContactNameCtl = new TextEditingController();
  // TextEditingController genderCtl = new TextEditingController();
  TextEditingController addressCtl = new TextEditingController();

  UserModel _userModel = UserModel();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String initialCountry = Countries.countyNames[0].toString().toUpperCase();
  PhoneNumber number = PhoneNumber(isoCode: 'UA');
  String birthday = "";
  DateTime birthDate = DateTime.now();
  int nowAge = 0;

  String _gender = '';

  // Form Validation Global key
  final _formKey = GlobalKey<FormState>();

  Future<void> updateData() async {
    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");

    try {
      _userModel.firstname = firstnameCtl.text;
      _userModel.lastname = lastnameCtl.text;
      _userModel.phoneNumber = phoneCtl.text;
      _userModel.address = addressCtl.text;
      _userModel.gender = _gender;
      _userModel.birthday = birthDate.millisecondsSinceEpoch;
      await UserRepository.updateUser(_userModel);
      AuthProvider.of(context).setUserModel(_userModel);
    } on FirebaseException catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: LocaleKeys.error.tr(),
        ),
      );
    } catch (e) {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      firstnameCtl.text = "";
      lastnameCtl.text = "";
      phoneCtl.text = "";
      ephoneCtl.text = "";
      eContactNameCtl.text = "";
      // genderCtl.text = "";
      addressCtl.text = "";
      birthday = "${birthDate.day}/${birthDate.month}/${birthDate.year}";
    });
  }

  @override
  void didUpdateWidget(covariant PersonalPage oldWidget) {
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (selected != null && selected != birthDate)
      setState(() {
        birthDate = selected;
        birthday = "${birthDate.day}/${birthDate.month}/${birthDate.year}";
        nowAge = DateTime.now().year - birthDate.year;
      });
  }

  @override
  Widget build(BuildContext context) {
    // Strings

    String title = LocaleKeys.personalPage_title.tr();
    String firsname = LocaleKeys.personalPage_firsname.tr();
    String lastname = LocaleKeys.personalPage_lastname.tr();
    String phoneNumber = LocaleKeys.personalPage_phoneNumber.tr();
    String ePhoneNumber = LocaleKeys.personalPage_ePhoneNumber.tr();
    String eContact = LocaleKeys.personalPage_contactName.tr();
    String addNumber = LocaleKeys.personalPage_addNumber.tr();
    String gender = LocaleKeys.personalPage_gender.tr();
    String birth = LocaleKeys.personalPage_birth.tr();
    String age = LocaleKeys.personalPage_age.tr();
    String address = LocaleKeys.personalPage_address.tr();
    String updateBtn = LocaleKeys.personalPage_updateBtn.tr();

    String firsnameLengthError =
        LocaleKeys.lengthError.tr(args: ['firtname', '2', '25']);
    String lastnameLengthError =
        LocaleKeys.lengthError.tr(args: ['firtname', '2', '30']);
    String phoneLengthError =
        LocaleKeys.lengthError.tr(args: ['PhoneNumber', '6', '20']);
    String addressLengthError =
        LocaleKeys.lengthError.tr(args: ['address', '6', '20']);
    String formatError = LocaleKeys.formatError.tr();

    //-------------------------------------------------------
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    double statusH = MediaQuery.of(context).viewPadding.top;
    _userModel = AuthProvider.of(context).userModel;

    firstnameCtl.text =
        (firstnameCtl.text != "") ? firstnameCtl.text : _userModel.firstname;
    lastnameCtl.text =
        (lastnameCtl.text != "") ? lastnameCtl.text : _userModel.lastname;
    phoneCtl.text =
        (phoneCtl.text != "") ? phoneCtl.text : _userModel.phoneNumber;
    addressCtl.text =
        (addressCtl.text != "") ? addressCtl.text : _userModel.address;

    birthDate = (_userModel.birthday != 0)
        ? DateTime.fromMillisecondsSinceEpoch(_userModel.birthday)
        : birthDate;
    nowAge = DateTime.now().year - birthDate.year;
    _gender = (_userModel.gender != "") ? _userModel.gender : "Male";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title,
          style: PersonalPageStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height - statusH,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: PersonalPageColors.fillColor,
                            image: (_userModel.avatar != "" &&
                                    _userModel.avatar != null)
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
                              color: PersonalPageColors.iconColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.uploadPhoto);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: PersonalPageColors.iconColor,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.photo_camera,
                              color: PersonalPageColors.iconColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 26),
                      // First Name
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              firsname,
                              style: PersonalPageStyles.text,
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      InputBox(
                        controller: firstnameCtl,
                        hint: "Johne",
                        icon: Icon(
                          FontAwesomeIcons.solidAddressBook,
                          color: PersonalPageColors.iconColor,
                        ),
                        activeColor: AppColors.activeColor,
                        normalColor: PersonalPageColors.iconColor,
                        maxLength: 25,
                        validator: (value) {
                          final reg = RegExp(r'^[a-zA-Z]+$');
                          if (value.length < 2 || value.length > 25) {
                            return firsnameLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else {
                            return null;
                          }
                        },
                      ),

                      // Last Name
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              lastname,
                              style: PersonalPageStyles.text,
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      InputBox(
                        controller: lastnameCtl,
                        hint: "Doe",
                        icon: Icon(
                          FontAwesomeIcons.solidAddressBook,
                          color: PersonalPageColors.iconColor,
                        ),
                        activeColor: AppColors.activeColor,
                        normalColor: PersonalPageColors.iconColor,
                        maxLength: 30,
                        validator: (value) {
                          final reg = RegExp(r'^[a-zA-Z]+$');
                          if (value.length < 2 || value.length > 30) {
                            return lastnameLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else {
                            return null;
                          }
                        },
                      ),

                      // Phone Number
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          phoneNumber,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      PhoneNumberBox(
                        controller: phoneCtl,
                        hint: "289 943 65 23",
                        icon: Icon(
                          Icons.phone,
                          color: PersonalPageColors.iconColor,
                        ),
                        activeColor: AppColors.activeColor,
                        normalColor: PersonalPageColors.iconColor,
                        maxLength: 20,
                        validator: (value) {
                          final reg = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
                          if (value.length < 6 || value.length > 20) {
                            return phoneLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else {
                            return null;
                          }
                        },
                      ),

                      // Emergency Phone Number
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          ePhoneNumber,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      PhoneNumberBox(
                        controller: ephoneCtl,
                        hint: "289 943 65 23",
                        icon: Icon(
                          Icons.phone,
                          color: PersonalPageColors.iconColor,
                        ),
                        activeColor: AppColors.activeColor,
                        normalColor: PersonalPageColors.iconColor,
                        // validator: (value) {
                        //   return null;
                        // },
                      ),

                      // Contact Name
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          eContact,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      InputBox(
                          controller: eContactNameCtl,
                          hint: "Mom",
                          icon: Icon(
                            FontAwesomeIcons.solidAddressBook,
                            color: PersonalPageColors.iconColor,
                          ),
                          activeColor: AppColors.activeColor,
                          normalColor: PersonalPageColors.iconColor,
                          validator: (value) {
                            return null;
                          }),

                      // Add Number
                      SizedBox(
                        height: 35,
                      ),
                      TouchEffect(
                        onTap: () {
                          print("SFSDFSDFSD");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.activeColor,
                            ),
                            Container(
                              // margin: EdgeInsets.only(top: 35),
                              child: Text(
                                addNumber,
                                style: TextStyle(
                                    color: AppColors.activeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Gender
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          gender,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      DropDownBox(
                        hint: Text(
                          "Male",
                          style: PersonalPageStyles.inputText,
                        ),
                        textStyle: PersonalPageStyles.inputText,
                        items: ["Male", "Female"],
                        initValue: _gender,
                        activeColor: AppColors.activeColor,
                        normalColor: PersonalPageColors.iconColor,
                        onChange: (value) {
                          print(value);
                          setState(() {
                            _gender = value;
                          });
                        },
                        validator: (value) {
                          print(value);
                        },
                      ),

                      // Birthday
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          birth,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: PersonalPageColors.iconColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              birthday,
                              style: PersonalPageStyles.inputText,
                            ),
                            IconButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              icon: Icon(
                                AllerG.calendar_outlilne,
                                color: PersonalPageColors.iconColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      // Age
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          age,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: PersonalPageColors.iconColor,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '$nowAge years',
                              style: PersonalPageStyles.inputText,
                            ),
                            Icon(
                              AllerG.hourglass,
                              color: PersonalPageColors.iconColor,
                            )
                          ],
                        ),
                      ),

                      // Address
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          address,
                          style: PersonalPageStyles.text,
                        ),
                      ),
                      InputBox(
                        controller: addressCtl,
                        hint: "Ukraine, Kyiv, Tupoleva st, 5d",
                        icon: Icon(
                          AllerG.location_inv,
                          color: PersonalPageColors.iconColor,
                        ),
                        activeColor: AppColors.activeColor,
                        normalColor: PersonalPageColors.iconColor,
                        maxLength: 50,
                        validator: (value) {
                          final reg = RegExp(r'^[a-zA-Z0-9 ]+$');
                          if (value.length < 3 || value.length > 50) {
                            return addressLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else {
                            return null;
                          }
                        },
                      ),

                      // Update Button
                      const SizedBox(
                        height: 40,
                      ),
                      MainButton(
                          title: updateBtn,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await updateData();
                            }
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}
