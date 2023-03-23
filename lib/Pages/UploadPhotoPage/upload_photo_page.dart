import 'dart:io';

import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:allger/Models/index.dart';
import 'package:allger/Pages/App/Provider/app_provider.dart';
import 'package:allger/Pages/App/Provider/auth_provider.dart';
import 'package:allger/Pages/App/Styles/colors.dart';
import 'package:allger/Pages/App/Styles/index.dart';
import 'package:allger/Pages/PersonalPage/Styles/strings.dart';
import 'package:allger/Pages/PersonalPage/personal_page.dart';
import 'package:allger/Pages/UploadPhotoPage/Styles/index.dart';
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

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File? _imageFile;
  String path = "";
  bool isFile = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  UserModel userModel = UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant UploadPhotoPage oldWidget) {
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

  Future uploadImageToFirebase(BuildContext context) async {
    // ========== Show Progress Dialog ===========
    Dialogs.showLoadingDialog(context, _keyLoader, "Uploading..");

    String fileName = basename(_imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        print("-- COmplete Upload -------");
      });
      taskSnapshot.ref.getDownloadURL().then(
        (value) async {
          print("-- COmplete Upload -------");

          print("Done: $value");
          // setState(() {});
          userModel.avatar = '$value';
          AuthProvider.of(context).setUserModel(userModel);

          await UserRepository.updateUser(userModel);
          //---- Show Error Msg
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: LocaleKeys.uploadPhotoPage_success,
            ),
          );
        },
      );
    } catch (e) {
      //  Show Error
      //---- Show Error Msg
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: LocaleKeys.error,
        ),
      );
    }

    //------------ Dismiss Porgress Dialog  -------------------
    Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
  }

  final picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      _imageFile = File(pickedFile!.path);
      path = _imageFile!.path;
      isFile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // String
    String title = LocaleKeys.uploadPhotoPage_title.tr();
    String source = LocaleKeys.uploadPhotoPage_source.tr();
    String or = LocaleKeys.uploadPhotoPage_or.tr();
    String takePhoto = LocaleKeys.uploadPhotoPage_takePhoto.tr();
    // String success = LocaleKeys.uploadPhotoPage_.tr();
    String error = LocaleKeys.error.tr();
    //-----------------------------------------------------------
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.statusbarColor,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
      //set brightness for icons, like dark background light icons
    ));

    double statusH = MediaQuery.of(context).viewPadding.top;
    UserModel _userModel = AuthProvider.of(context).userModel;
    userModel = _userModel;
    path = (_userModel.avatar != "" && _userModel.avatar != null)
        ? _userModel.avatar
        : AppStrings.defaultAvatar;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title,
          style: UploadPhotoPageStyles.title,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 160,
                        width: 160,
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            image: (_imageFile != null)
                                ? DecorationImage(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.fill,
                                  )
                                : (_userModel.avatar != "" &&
                                        _userModel.avatar != null)
                                    ? DecorationImage(
                                        image: NetworkImage(_userModel.avatar),
                                        fit: BoxFit.fill,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(
                                            AppStrings.defaultAvatar),
                                        fit: BoxFit.fill,
                                      ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: UploadPhotoPageColors.mainColor,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.photo_camera,
                            color: UploadPhotoPageColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 160,
                  child: Text(
                    source,
                    textAlign: TextAlign.center,
                    style: UploadPhotoPageStyles.subText,
                  ),
                ),
                Text(
                  or,
                  style: UploadPhotoPageStyles.orText,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TouchEffect(
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 65),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: UploadPhotoPageColors.mainColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        takePhoto,
                        style: UploadPhotoPageStyles.takePhotoTxt,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                MainButton(
                    title: LocaleKeys.personalPage_updateBtn.tr(),
                    onTap: () async {
                      await uploadImageToFirebase(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
