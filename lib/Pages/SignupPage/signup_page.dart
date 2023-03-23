import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Helpers/index.dart';
import 'package:allger/Models/index.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/LoginPage/login_item.dart';
import 'package:allger/Pages/SignupPage/Styles/index.dart';
import 'package:allger/Repositories/index.dart';
import 'package:allger/Route/routes.dart';
import 'package:allger/Widgets/TouchEffect.dart';
import 'package:allger/Widgets/index.dart';
import 'package:allger/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailCtl = new TextEditingController();
  TextEditingController usernameCtl = new TextEditingController();
  TextEditingController passwordCtl = new TextEditingController();
  TextEditingController rpasswordCtl = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  // Form Validation Global key
  final _formKey = GlobalKey<FormState>();

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

  //  SignUp
  Future<void> signUp() async {
    String email = emailCtl.text;
    String username = usernameCtl.text;
    String pass = passwordCtl.text;

    int _result = 0;
    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      print("-------- Signup Successfully!-----------------");

      print(userCredential.user);
      await getUser(userCredential.user!);
      _result = 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _result = 2;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _result = 3;
      }
    } catch (e) {
      print(e);
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
        // showTopSnackBar(
        //   context,
        //   CustomSnackBar.success(
        //     message: "Logined successfully!",
        //   ),
        // );
        Navigator.pushReplacementNamed(context, Routes.profile);

        break;

      case 2:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.signupPage_weakPass.tr(),
          ),
        );
        break;

      case 3:
        //---- Show Error Msg
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: LocaleKeys.signupPage_existEmail.tr(),
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
    int _result = 0;
    try {
      User? user = await GoogleAuth.signInWithGoogle(context: context);

      // ========== Show Progress Dialog ===========
      Dialogs.showLoadingDialog(context, _keyLoader, "Please wait..");
      try {
        await getUser(user!);
      } catch (e) {}
      _result = 1;
    } catch (e) {
      print(e);
      _result = 2;
    }
    //------------ Dismiss Porgress Dialog  -------------------
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    await toDoResult(_result);

    // return user;
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase();

    setState(() {
      emailCtl.text = "";
      usernameCtl.text = "";
      passwordCtl.text = "";
      rpasswordCtl.text = "";
    });
  }

  @override
  void didUpdateWidget(covariant SignupPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    // FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    // Strings
    String title = LocaleKeys.signupPage_title.tr();
    String signupBtn = LocaleKeys.signupPage_signinBtn.tr();
    String loginBtn = LocaleKeys.signupPage_signinBtn.tr();
    String hintEmail = LocaleKeys.signupPage_email.tr();
    String hintUsername = LocaleKeys.signupPage_username.tr();
    String hintPassword = LocaleKeys.signupPage_password.tr();
    String hintRPassword = LocaleKeys.signupPage_RPassword.tr();
    String signupWith = LocaleKeys.signupPage_signupWith.tr();
    String alreadyAccount = LocaleKeys.signupPage_alreadyAccount.tr();
    String validEmail = LocaleKeys.validEmail.tr();
    String emailLengthError =
        LocaleKeys.lengthError.tr(args: ['email', '6', '50']);
    String usernameLengthError =
        LocaleKeys.lengthError.tr(args: ['username', '6', '10']);
    String passLengthError = LocaleKeys.lengthError.tr(args: [
      'password',
      '8',
      '20',
    ]);
    String formatError = LocaleKeys.formatError.tr();
    String confirmPassError = LocaleKeys.confirmPassError.tr();

    String weakPass = LocaleKeys.signupPage_weakPass.tr();
    String existEmail = LocaleKeys.signupPage_existEmail.tr();
    String error = LocaleKeys.error.tr();
    ///////////////////////////////////////////////////////////////////
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      statusBarIconBrightness: Brightness.light,
    ));

    var appBar = AppBar(
      backgroundColor: AppColors.appBarColor,
      title: Text(
        title,
        style: SignupPageStyles.title,
      ),
    );
    double statusH = MediaQuery.of(context).viewPadding.top;

    double appbarH = appBar.preferredSize.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - statusH - appbarH,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(SignupPageStrings.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 130,
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 30,
                      ),
                      decoration: BoxDecoration(
                          color: SignupPageColors.backColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              textAlign: TextAlign.start,
                              style: SignupPageStyles.title1,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: loginItem(
                                    img: SignupPageStrings.googleIcon,
                                    onTap: () async {
                                      print("AAAAA");
                                      await signInWithGoogle();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: loginItem(
                                    img: SignupPageStrings.fbIcon,
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
                                    img: SignupPageStrings.appleIcon,
                                    onTap: () {
                                      print("CCC");
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: width,
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                signupWith,
                                textAlign: TextAlign.center,
                                style: SignupPageStyles.regEmail,
                              ),
                            ),
                            const SizedBox(height: 22),
                            InputBox(
                              controller: emailCtl,
                              hint: hintEmail,
                              icon: Icon(
                                Icons.email,
                                size: 18,
                                color: SignupPageColors.greyColor,
                              ),
                              activeColor: SignupPageColors.activeColor,
                              normalColor: SignupPageColors.greyColor,
                              hintStyle: SignupPageStyles.hint,
                              textStyle: SignupPageStyles.inputTxt,
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
                            InputBox(
                              controller: usernameCtl,
                              hint: hintUsername,
                              icon: Icon(
                                AllerG.user,
                                size: 18,
                                color: SignupPageColors.greyColor,
                              ),
                              activeColor: SignupPageColors.activeColor,
                              normalColor: SignupPageColors.greyColor,
                              hintStyle: SignupPageStyles.hint,
                              textStyle: SignupPageStyles.inputTxt,
                              maxLength: 10,
                              validator: (value) {
                                final reg = RegExp(r'^[a-zA-Z0-9@.]+$');
                                if (value.length < 6 || value.length > 10) {
                                  return usernameLengthError;
                                } else if (!reg.hasMatch(value)) {
                                  return formatError;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 25),
                            PasswordBox(
                              controller: passwordCtl,
                              hint: hintPassword,
                              iconColor: SignupPageColors.greyColor,
                              activeColor: SignupPageColors.activeColor,
                              normalColor: SignupPageColors.greyColor,
                              hintStyle: SignupPageStyles.hint,
                              textStyle: SignupPageStyles.inputTxt,
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
                            PasswordBox(
                              controller: rpasswordCtl,
                              hint: hintRPassword,
                              iconColor: SignupPageColors.greyColor,
                              activeColor: SignupPageColors.activeColor,
                              normalColor: SignupPageColors.greyColor,
                              hintStyle: SignupPageStyles.hint,
                              textStyle: SignupPageStyles.inputTxt,
                              maxLength: 20,
                              validator: (value) {
                                final reg = RegExp(r'^[a-zA-Z0-9]+$');
                                if (value.length < 8 || value.length > 20) {
                                  return passLengthError;
                                } else if (!reg.hasMatch(value)) {
                                  return formatError;
                                } else if (rpasswordCtl.text !=
                                    passwordCtl.text) {
                                  return confirmPassError;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 40),
                            MainButton(
                              title: signupBtn,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await signUp();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  alreadyAccount,
                                  style: SignupPageStyles.dontAccount,
                                ),
                                TouchEffect(
                                  child: Text(
                                    loginBtn,
                                    style: SignupPageStyles.signupBtnTxt,
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(Routes.login);
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 42,
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
