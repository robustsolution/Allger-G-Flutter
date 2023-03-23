import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LoginInfoPage/Styles/index.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginInfoPage extends StatefulWidget {
  // final String title;

  // LoginInfoPage({Key? key, required this.title}) : super(key: key);
  @override
  _LoginInfoPageState createState() => _LoginInfoPageState();
}

class _LoginInfoPageState extends State<LoginInfoPage> {
  TextEditingController usernameCtl = new TextEditingController();
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController curPassCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  TextEditingController rpasswordCtl = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  // String initialCountry = Countries.countyNames[0].toString().toUpperCase();
  // PhoneNumber number = PhoneNumber(isoCode: 'UA');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeFirebase();

    setState(() {
      usernameCtl.text = "";
      emailCtl.text = "";
      curPassCtl.text = "";
      passwordCtl.text = "";
      rpasswordCtl.text = "";
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));
  }

  @override
  void didUpdateWidget(covariant LoginInfoPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // FocusScope.of(context).requestFocus(new FocusNode());
  }

  // Initialize Firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  // Update
  Future<void> update() async {
    // // ========== Show Progress Dialog ===========
    // Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");

    try {
      // Prompt the user to enter their email and password
      //Create an instance of the current user.
      User user = await FirebaseAuth.instance.currentUser!;
      if (user.email != emailCtl.text) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.loginInfoPage_incorrectEmail.tr(),
          ),
        );
        return;
      }
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: curPassCtl.text);

      user.reauthenticateWithCredential(cred).then((value) {
        //Pass in the password to updatePassword.
        user.updatePassword(passwordCtl.text).then((_) {
          print("Successfully changed password");
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: LocaleKeys.success.tr(args: ["Update"]),
            ),
          );
        }).catchError((error) {
          print("Password can't be changed" + error.toString());
          //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: LocaleKeys.error.tr(),
            ),
          );
        });
      }).catchError((onError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.loginPage_wrongpass.tr(),
          ),
        );
      });
      print("----------- SuccessFully ----------");
    } on FirebaseAuth catch (e) {
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
    // // ========== Show Progress Dialog ===========
    // Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
  }

  @override
  Widget build(BuildContext context) {
    // String
    String title = LocaleKeys.loginInfoPage_title.tr();
    String username = LocaleKeys.loginInfoPage_username.tr();
    String email = LocaleKeys.loginInfoPage_email.tr();
    String password = LocaleKeys.loginInfoPage_password.tr();
    String rpassword = LocaleKeys.loginInfoPage_rpassword.tr();
    String changePass = LocaleKeys.loginInfoPage_changePass.tr();
    String updateBtn = LocaleKeys.personalPage_updateBtn.tr();
    String emailLengthError =
        LocaleKeys.lengthError.tr(args: ['email', '6', '50']);
    String validEmail = LocaleKeys.validEmail.tr();
    String passLengthError = LocaleKeys.lengthError.tr(args: [
      'password',
      '8',
      '20',
    ]);
    String formatError = LocaleKeys.formatError.tr();
    String confirmPassError = LocaleKeys.confirmPassError.tr();
    String currentPass = LocaleKeys.loginInfoPage_currentPass.tr();

    //---------------------------------------------------------
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
          style: LoginInfoPageStyles.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - statusH,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // const SizedBox(height: 26),
                      // username
                      // Container(
                      //   margin: EdgeInsets.only(top: 25, bottom: 10),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Text(
                      //         username,
                      //         style: LoginInfoPageStyles.text,
                      //       ),
                      //       Text(
                      //         "*",
                      //         style: TextStyle(color: Colors.red),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // InputBox(
                      //     controller: usernameCtl,
                      //     hint: username,
                      //     icon: Icon(
                      //       FontAwesomeIcons.solidAddressBook,
                      //       color: LoginInfoPageColors.iconColor,
                      //     ),
                      //     activeColor: AppColors.activeColor,
                      //     normalColor: LoginInfoPageColors.iconColor),

                      // email
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              email,
                              style: LoginInfoPageStyles.text,
                            ),
                            const Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      InputBox(
                        controller: emailCtl,
                        hint: email,
                        icon: Icon(
                          FontAwesomeIcons.solidAddressBook,
                          color: LoginInfoPageColors.iconColor,
                        ),
                        activeColor: AppColors.activeColor,
                        normalColor: LoginInfoPageColors.iconColor,
                        maxLength: 50,
                        validator: (value) {
                          return EmailValidator.validate(value)
                              ? (value.length < 6 || value.length > 50)
                                  ? emailLengthError
                                  : null
                              : validEmail;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          currentPass,
                          style: LoginInfoPageStyles.text,
                        ),
                      ),
                      PasswordBox(
                        controller: curPassCtl,
                        hint: currentPass,
                        activeColor: AppColors.activeColor,
                        normalColor: LoginInfoPageColors.iconColor,
                        maxLength: 20,
                        validator: (value) {
                          final reg = RegExp(r'^[a-zA-Z0-9]+$');
                          if (value.length < 8 || value.length > 20) {
                            return passLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else {
                            return null;
                          }
                        },
                      ),

                      // Password
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          changePass,
                          style: LoginInfoPageStyles.text,
                        ),
                      ),
                      PasswordBox(
                        controller: passwordCtl,
                        hint: password,
                        activeColor: AppColors.activeColor,
                        normalColor: LoginInfoPageColors.iconColor,
                        maxLength: 20,
                        validator: (value) {
                          final reg = RegExp(r'^[a-zA-Z0-9]+$');
                          if (value.length < 8 || value.length > 20) {
                            return passLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Repeat Password
                      PasswordBox(
                        controller: rpasswordCtl,
                        hint: rpassword,
                        activeColor: AppColors.activeColor,
                        normalColor: LoginInfoPageColors.iconColor,
                        maxLength: 20,
                        validator: (value) {
                          final reg = RegExp(r'^[a-zA-Z0-9]+$');
                          if (value.length < 8 || value.length > 20) {
                            return passLengthError;
                          } else if (!reg.hasMatch(value)) {
                            return formatError;
                          } else if (rpasswordCtl.text != passwordCtl.text) {
                            return confirmPassError;
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
                              await update();
                            }
                          })
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
