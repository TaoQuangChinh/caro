// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.email,
    this.nickName,
    this.mobiDevice,
  });

  String? id;
  String? email;
  String? nickName;
  String? mobiDevice;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        nickName: json["nick_name"] == null ? null : json["nick_name"],
        mobiDevice: json["mobi_device"] == null ? null : json["mobi_device"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "nick_name": nickName == null ? null : nickName,
        "mobi_device": mobiDevice == null ? null : mobiDevice,
      };
}
