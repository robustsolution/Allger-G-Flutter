import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:allger/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:within/Models/index.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<AuthProvider>(context, listen: listen);

  /// user info - login info

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;
  Future<void> setUserModel(UserModel userModel,
      {bool isNotifiable = true}) async {
    _userModel = userModel;
    if (isNotifiable) notifyListeners();
  }

  // User _user;
  // User get userData => _user;
  // setUserData(User user) {
  //   _user = user;
  //   notifyListeners();
  // }
  // AuthState _loginState = AuthState.IsNotLogin;
  // AuthState get loginState => _loginState;
  // void setLoginState(AuthState loginState, {bool isNotifiable = true}) {
  //   if (_loginState != loginState) {
  //     _loginState = loginState;
  //     if (isNotifiable) notifyListeners();
  //   }
  // }

  // /// auth errorString
  // String _errorString = "";
  // String get errorString => _errorString;
  // void setErrorString(String errorString, {bool isNotifiable = true}) {
  //   if (_errorString != errorString) {
  //     _errorString = errorString;
  //     if (isNotifiable) notifyListeners();
  //   }
  // }

  // int _authState = 0; // 0: init, 1: doing login, 2: success, -1: fail
  // int get authState => _authState;
  // void setAuthState(int authState, {bool isNotifiable = true}) {
  //   if (_authState != authState) {
  //     _authState = authState;
  //     if (isNotifiable) notifyListeners();
  //   }
  // }

  // Future<void> init(FirebaseUser firebaseUser) async {
  //   try {
  //     _rememberMe = await getDataInLocal(
  //         key: _rememberMeStoreKey, type: StorableDataType.BOOL);
  //     if (_rememberMe == null) _rememberMe = false;

  //     /// if remember me is true
  //     if (_rememberMe) {
  //       var userData = await getUserDataFromFirebaseUser(firebaseUser);

  //       if (!userData["state"]) {
  //         _rememberMe = false;
  //         _userModel = UserModel();
  //         _loginState = AuthState.IsNotLogin;
  //       } else {
  //         _userModel = UserModel.fromJson(userData["data"][0]);
  //         if (_userModel.membershipEndDate <=
  //             DateTime.now().millisecondsSinceEpoch) {
  //           _userModel.haveMemberShip = false;
  //           _userModel.membershipType = -1;
  //           _userModel.membershipEndDate = 0;
  //         }
  //         _loginState = AuthState.IsLogin;
  //         setRememberMe(_rememberMe, isNotifiable: false);
  //       }
  //     }

  //     /// if remember me is true
  //     else {
  //       _rememberMe = false;
  //       _userModel = UserModel();
  //       _loginState = AuthState.IsNotLogin;
  //     }
  //   } catch (e) {
  //     _rememberMe = false;
  //     _userModel = UserModel();
  //     _loginState = AuthState.IsNotLogin;
  //   }
  //   notifyListeners();
  // }

  // Future<void> resetPassword({String email}) async {
  //   Map<String, dynamic> result =
  //       await KeicyAuthentication.instance.resetPassword(email: email);
  //   if (result["state"]) {
  //     _errorString =
  //         "A reset link has been sent to your email, click it to reset your password.";
  //     notifyListeners();
  //   } else {
  //     _errorString = result["errorString"];
  //     notifyListeners();
  //   }
  // }

  // void signupWithEmailOnFirebase(
  //     {@required UserModel userModel,
  //     @required String password,
  //     bool remeberMe = true}) async {
  //   Map<String, dynamic> authResult = await KeicyAuthentication.instance
  //       .signUp(email: userModel.email, password: password);
  //   if (!authResult["state"]) {
  //     _authState = -1;
  //     _errorString = authResult["errorString"];
  //     notifyListeners();
  //     return;
  //   }

  //   userModel.uid = authResult["user"].uid;
  //   userModel.fcmToken = await KeicyFCMForMobile.instance.getToken();

  //   Map<String, dynamic> userData = await UserRepository.addUser(userModel);
  //   if (!userData["state"]) {
  //     _authState = -1;
  //     _errorString = userData["errorString"];
  //     notifyListeners();
  //     return;
  //   }

  //   _errorString = "";
  //   _authState = 2;
  //   _userModel = UserModel.fromJson(userData["data"][0]);
  //   _loginState = AuthState.IsLogin;
  //   setRememberMe(remeberMe, isNotifiable: false);
  //   notifyListeners();
  // }

  // void loginWithEmailOnFirebase(
  //     {@required String email,
  //     @required String password,
  //     bool remeberMe = true}) async {
  //   Map<String, dynamic> authResult = await KeicyAuthentication.instance
  //       .signIn(email: email, password: password);
  //   if (!authResult["state"]) {
  //     _errorString = authResult["errorString"];
  //     _authState = -1;
  //     notifyListeners();
  //     return;
  //   }

  //   var userData = await getUserDataFromFirebaseUser(authResult["user"]);

  //   /// if failed, display error.
  //   if (!userData["state"]) {
  //     _errorString = userData["errorString"];
  //     _authState = -1;
  //     _userModel = UserModel();
  //     _loginState = AuthState.IsNotLogin;
  //   } else {
  //     _errorString = "";
  //     _authState = 2;
  //     _userModel = UserModel.fromJson(userData["data"][0]);
  //     _loginState = AuthState.IsLogin;
  //     setRememberMe(remeberMe, isNotifiable: false);
  //   }
  //   notifyListeners();
  // }

  // void logout() async {
  //   try {
  //     await KeicyAuthentication.instance.signOut();
  //     _authState = 2;
  //     _errorString = "";
  //     await setRememberMe(false, isNotifiable: false);
  //     _userModel = UserModel();
  //     _loginState = AuthState.IsNotLogin;
  //     notifyListeners();
  //   } catch (e) {
  //     _authState = -1;
  //     _errorString = "Log out failed, please try again.";
  //     print(e);
  //   }
  // }

  // void loginWithGoogle({bool remeberMe = true}) async {
  //   var authResult = await KeicyAuthentication.instance.googleSignIn();

  //   if (!authResult["state"]) {
  //     _errorString = authResult["errorString"];
  //     _authState = -1;
  //     notifyListeners();
  //     return;
  //   }

  //   var userData = await getUserDataFromFirebaseUser(authResult["user"]);

  //   /// if failed, display error.
  //   if (!userData["state"]) {
  //     _errorString = userData["errorString"];
  //     _authState = -1;
  //     _userModel = UserModel();
  //     _loginState = AuthState.IsNotLogin;
  //   } else {
  //     _errorString = "";
  //     _authState = 2;
  //     _userModel = UserModel.fromJson(userData["data"][0]);
  //     _loginState = AuthState.IsLogin;
  //     setRememberMe(remeberMe, isNotifiable: false);
  //   }
  //   notifyListeners();
  // }

  // Future<Map<String, dynamic>> getUserDataFromFirebaseUser(
  //     FirebaseUser firebaseUser) async {
  //   String fcmToken = await KeicyFCMForMobile.instance.getToken();

  //   print("---------------- TOKEN $fcmToken ------------------");

  //   /// check if the user exist
  //   Map<String, dynamic> userDataResult =
  //       await UserRepository.getUserByUID(firebaseUser.uid);

  //   /// if failed,
  //   if (!userDataResult["state"]) {
  //     return userDataResult;
  //   }

  //   /// if the user don't exist, create User document
  //   else if (userDataResult["data"].length == 0) {
  //     UserModel _userModel = UserModel();
  //     _userModel.uid = firebaseUser.uid;
  //     _userModel.name = firebaseUser.displayName;
  //     _userModel.email = firebaseUser.email;
  //     _userModel.phoneNumber = firebaseUser.phoneNumber;
  //     _userModel.fcmToken = fcmToken;

  //     return await UserRepository.addUser(_userModel);
  //   }

  //   /// if the user already exist, get the User document
  //   else {
  //     if (fcmToken != userDataResult["data"][0]["fcmToken"]) {
  //       userDataResult["data"][0]["fcmToken"] = fcmToken;
  //       await UserRepository.updateUser(
  //           UserModel.fromJson(userDataResult["data"][0]));
  //     }
  //     return userDataResult;
  //   }
  // }
}
