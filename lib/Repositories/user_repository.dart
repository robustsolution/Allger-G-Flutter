import 'dart:convert';

import 'package:allger/Models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  static String _userCollectionname = "users";

  static Future<void> addUser(UserModel userModel) async {
    print("------------ Rposiosdgag--------------");
    final DatabaseReference _usersRef = FirebaseDatabase.instance
        .reference()
        .child('$_userCollectionname/${userModel.uid}');
    await _usersRef.set(userModel.toJson());
  }

  // Get User with ID
  static Future getUserByID(String uid) async {
    DataSnapshot snap = await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(uid)
        .get();

    // jsonEncode(snap.value);
    // print(jsonDecode(jsonEncode(snap.value)));
    return (snap != null) ? jsonDecode(jsonEncode(snap.value)) : null;
  }

  // Update User
  static Future<void> updateUser(UserModel userModel) async {
    print("------------ Rposiosdgag--------------");
    final DatabaseReference _usersRef = FirebaseDatabase.instance
        .reference()
        .child('$_userCollectionname/${userModel.uid}');
    await _usersRef.update(userModel.toJson());
  }
}
