import 'dart:convert';

class EmergencyNumberModel {
  String uid;
  String contactName;
  String phoneNumber;
  // int ts;

  EmergencyNumberModel({
    this.uid = "",
    this.contactName = "",
    this.phoneNumber = "",
    // this.ts = 0,
  });

  EmergencyNumberModel.fromJson(Map<String, dynamic> json)
      : uid = (json['uid'] != null) ? json['uid'] : "",
        contactName = (json['contactName'] != null) ? json['contactName'] : "",
        phoneNumber = (json['phoneNumber'] != null) ? json['phoneNumber'] : "";
  // ts = (json['ts'] != null)
  //     ? json['ts']
  //     : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "uid": (uid == null) ? "" : uid,
      "contactName": (contactName == null) ? "" : contactName,
      "phoneNumber": (phoneNumber == null) ? "" : phoneNumber,
      // "ts": (ts == null) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }
}
