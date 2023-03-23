import 'package:allger/Helpers/index.dart';
import 'package:allger/Models/emergeny_number_model.dart';
import 'package:allger/Models/user_model.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/LoginPage/Styles/index.dart';
import 'package:allger/Pages/LoginPage/login_item.dart';
import 'package:allger/Repositories/user_repository.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  // Form Validation Global key
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeFirebase();

    setState(() {
      usernameCtl.text = "";
      passwordCtl.text = "";
    });
  }

  void login() async {
    String email = usernameCtl.text;
    String password = passwordCtl.text;

    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
    int _result = 0;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('_______ Logined Successfully ______________ \r\n');

      print(userCredential.user);
      await getUser(userCredential.user!);
      _result = 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _result = 2;
      } else if (e.code == 'wrong-password') {
        _result = 3;

        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.loginPage_wrongpass.tr(),
          ),
        );
      }
    } catch (e) {
      _result = 4;
    }

    //------------ Dismiss Porgress Dialog  -------------------
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    await toDoResult(_result);
  }

  Future<void> toDoResult(int result) async {
    switch (result) {
      case 1:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Logined successfully!",
          ),
        );
        Navigator.pushReplacementNamed(context, Routes.profile);

        break;

      case 2:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.loginPage_wrongUsername.tr(),
          ),
        );
        break;

      case 3:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.loginPage_wrongpass.tr(),
          ),
        );
        break;
      default:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.error,
          ),
        );
    }
  }

  Future<void> signInWithGoogle() async {
    // return user;
    try {
      User? user = await GoogleAuth.signInWithGoogle(context: context);

      // ========== Show Progress Dialog ===========
      Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
      try {
        await getUser(user!);
      } catch (e) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: e.toString(),
          ),
        );
      }

      //------------ Dismiss Porgress Dialog  -------------------
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      await toDoResult(1);
    } catch (e) {
      print(e);
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: e.toString(),
        ),
      );
    }

    // return user;
  }

  Future<void> getUser(User user) async {
    // await UserRepository.addUser(userModel)
    final result = await UserRepository.getUserByID(user.uid);

    if (result != null) {
      UserModel _userModel = UserModel.fromJson(result);
      _userModel.getEmergencyNumbers(result);
      AuthProvider.of(context).setUserModel(_userModel);
    } else {
      EmergencyNumberModel emodel = EmergencyNumberModel(
        uid: user.uid,
        contactName: "",
        phoneNumber: "",
      );

      UserModel _userModel = UserModel(
        uid: user.uid,
        email: user.email ?? "",
        fullname: user.displayName ?? "",
        avatar: user.photoURL ?? "",
        phoneNumber: user.phoneNumber ?? "",
        emergencyNumbers: [emodel],
        joined: (user.metadata.creationTime != null)
            ? user.metadata.creationTime!.millisecondsSinceEpoch
            : 0,
        ts: (user.metadata.lastSignInTime != null)
            ? user.metadata.lastSignInTime!.millisecondsSinceEpoch
            : 0,
      );

      try {
        await UserRepository.addUser(_userModel);

        AuthProvider.of(context).setUserModel(_userModel);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  void didUpdateWidget(covariant LoginPage oldWidget) {
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
    // Strings
    String title = LocaleKeys.loginPage_title.tr();
    String loginBtn = LocaleKeys.loginPage_signinBtn.tr();
    String forgotpass = LocaleKeys.loginPage_forgot.tr();
    String signupBtn = LocaleKeys.loginPage_signupBtn.tr();
    String hintUsername = LocaleKeys.loginPage_username.tr();
    String hintPassword = LocaleKeys.loginPage_password.tr();
    String loginWith = LocaleKeys.loginPage_loginWith.tr();
    String dontAccount = LocaleKeys.loginPage_dontaccount.tr();

    String validEmail = LocaleKeys.validEmail.tr();
    String emailLengthError =
        LocaleKeys.lengthError.tr(args: ['email', '6', '50']);

    String passLengthError = LocaleKeys.lengthError.tr(args: [
      'password',
      '8',
      '20',
    ]);

    String formatError = LocaleKeys.formatError.tr();

    String wrongUsername = LocaleKeys.loginPage_wrongUsername.tr();
    String wrongpass = LocaleKeys.loginPage_wrongpass.tr();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    var appBar = AppBar(
      backgroundColor: AppColors.appBarColor,
      title: Text(
        title,
        style: LoginPageStyles.title,
      ),
    );
    double statusH = MediaQuery.of(context).viewPadding.top;

    double appbarH = appBar.preferredSize.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - statusH - appbarH,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(LoginPageStrings.background),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Body
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 30, bottom: 42),
                  decoration: BoxDecoration(
                      color: LoginPageColors.backColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: LoginPageStyles.title1,
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        // Username
                        InputBox(
                          controller: usernameCtl,
                          hint: hintUsername,
                          icon: Icon(
                            AllerG.user,
                            size: 18,
                            color: LoginPageColors.greyColor,
                          ),
                          activeColor: LoginPageColors.activeColor,
                          normalColor: LoginPageColors.greyColor,
                          hintStyle: LoginPageStyles.hint,
                          textStyle: LoginPageStyles.inputTxt,
                          maxLength: 50,
                          validator: (value) {
                            return EmailValidator.validate(value)
                                ? (value.length < 6 || value.length > 50)
                                    ? emailLengthError
                                    : null
                                : validEmail;
                          },
                        ),
                        const SizedBox(height: 25),

                        // Password
                        PasswordBox(
                          controller: passwordCtl,
                          hint: hintPassword,
                          iconColor: LoginPageColors.greyColor,
                          activeColor: LoginPageColors.activeColor,
                          normalColor: LoginPageColors.greyColor,
                          hintStyle: LoginPageStyles.hint,
                          textStyle: LoginPageStyles.inputTxt,
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
                        const SizedBox(height: 25),

                        // Login Button
                        MainButton(
                            title: loginBtn,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                // _login(context);
                                login();
                              }
                            }
                            // {
                            // Navigator.pushReplacementNamed(
                            //     context, Routes.profile);
                            // },
                            ),
                        const SizedBox(
                          height: 15,
                        ),

                        // Forgot Password
                        TouchEffect(
                          onTap: () {},
                          child: Text(
                            forgotpass,
                            style: LoginPageStyles.forgotBtnTxt,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            loginWith,
                            textAlign: TextAlign.center,
                            style: LoginPageStyles.loginWith,
                          ),
                        ),

                        // Other Login Method
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: loginItem(
                                img: LoginPageStrings.googleIcon,
                                onTap: () async {
                                  await signInWithGoogle();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: loginItem(
                                img: LoginPageStrings.fbIcon,
                                onTap: () {
                                  print("BB");
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: loginItem(
                                img: LoginPageStrings.appleIcon,
                                onTap: () {
                                  print("CCC");
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        // SignUp
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              dontAccount,
                              style: LoginPageStyles.dontAccount,
                            ),
                            TouchEffect(
                              child: Text(
                                signupBtn,
                                style: LoginPageStyles.signupBtnTxt,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, Routes.register);
                              },
                            )
                          ],
                        )
                      ],
                    ),
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
