import 'dart:convert';

import 'package:allger/Models/emergeny_number_model.dart';

class UserModel {
  String uid;
  String username;
  String fullname;
  String firstname;
  String lastname;
  String avatar;
  String email;
  String phoneNumber;
  List<EmergencyNumberModel>? emergencyNumbers;
  int birthday;
  String gender;
  int age;
  String address;
  String allergyTypes;
  int joined;
  int weight;
  int height;
  int epiPen;
  int ts;

  UserModel({
    this.uid = "",
    this.username = "",
    this.fullname = "",
    this.firstname = "",
    this.lastname = "",
    this.avatar = "",
    this.email = "",
    this.phoneNumber = "",
    this.emergencyNumbers,
    this.birthday = 0,
    this.gender = "",
    this.age = 0,
    this.address = "",
    this.allergyTypes = "",
    this.joined = 0,
    this.ts = 0,
    this.weight = 1,
    this.epiPen = 0,
    this.height = 1,
  });

  UserModel.fromJson(Map json)
      : uid = (json['uid'] != null) ? json['uid'] : "",
        username = (json['username'] != null) ? json['username'] : "",
        fullname = (json['fullname'] != null) ? json['fullname'] : "",
        firstname = (json['firstname'] != null) ? json['firstname'] : "",
        lastname = (json['lastname'] != null) ? json['lastname'] : "",
        avatar = (json['avatar'] != null) ? json['avatar'] : "",
        email = (json['email'] != null) ? json['email'] : "",
        phoneNumber = (json['phoneNumber'] != null) ? json['phoneNumber'] : "",
        // emergencyNumbers =
        //     (json['emergencyNumbers'] != null) ? json['emergencyNumbers'] : [],
        birthday = (json['birthday'] != null) ? json['birthday'] : 0,
        gender = (json['gender'] != null) ? json['gender'] : "",
        age = (json['age'] != null) ? json['age'] : 1,
        weight = (json['weight'] != null) ? json['weight'] : 1,
        height = (json['height'] != null) ? json['height'] : 1,
        epiPen = (json['epiPen'] != null) ? json['epiPen'] : 0,
        address = (json['address'] != null) ? json['address'] : "",
        allergyTypes =
            (json['allergyTypes'] != null) ? json['allergyTypes'] : "",
        joined = (json['joined'] != null)
            ? json['joined']
            : DateTime.now().millisecondsSinceEpoch,
        ts = (json['ts'] != null)
            ? json['ts']
            : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "uid": (uid == null) ? "" : uid,
      "username": (username == null) ? "" : username,
      "fullname": (fullname == null) ? "" : fullname,
      "firstname": (firstname == null) ? "" : firstname,
      "lastname": (lastname == null) ? "" : lastname,
      "avatar": (avatar == null) ? "" : avatar,
      "email": (email == null) ? "" : email,
      "phoneNumber": (phoneNumber == null) ? "" : phoneNumber,
      "emergencyNumbers":
          (emergencyNumbers == null) ? [] : convertList(emergencyNumbers!),
      "birthday": (birthday == null) ? 0 : birthday,
      "gender": (gender == null) ? "" : gender,
      "allergyTypes": (allergyTypes == null) ? "" : allergyTypes,
      "address": (address == null) ? "" : address,
      "age": (age == null) ? 0 : age,
      "weight": (weight == null) ? 1 : weight,
      "height": (height == null) ? 1 : height,
      "epiPen": (epiPen == null) ? 0 : epiPen,
      "joined": (joined == null || joined == 0)
          ? DateTime.now().millisecondsSinceEpoch
          : joined,
      "ts":
          (ts == null || ts == 0) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }

  void getEmergencyNumbers(Map json) {
    List eNumbers = json['emergencyNumbers'];
    List<EmergencyNumberModel> eNumberList = [];

    eNumbers.forEach((element) {
      EmergencyNumberModel eNumberModel =
          EmergencyNumberModel.fromJson(element);
      eNumberList.add(eNumberModel);
    });

    this.emergencyNumbers = eNumberList;
  }

  List convertList(List<EmergencyNumberModel> list) {
    return list.map((item) {
      return {
        "uid": item.uid,
        "contactName": item.contactName,
        "phoneNumber": item.phoneNumber,
      };
    }).toList();
  }
}
