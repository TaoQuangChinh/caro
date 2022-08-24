// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.id,
      this.email,
      this.pass,
      this.userName,
      this.deviceMobi,
      this.images,
      this.saveAccount});

  String? id;
  String? email;
  String? pass;
  String? userName;
  String? deviceMobi;
  String? images;
  String? saveAccount;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] == null ? null : json["id"],
      email: json["email"] == null ? null : json["email"],
      pass: json["pass"] == null ? null : json["pass"],
      userName: json["user_name"] == null ? null : json["user_name"],
      deviceMobi: json["device_mobi"] == null ? null : json["device_mobi"],
      images: json["images"] == null || json["images"] == ''
          ? null
          : json["images"],
      saveAccount: json["save_account"] == null ? null : json["save_account"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "pass": pass == null ? null : pass,
        "user_name": userName == null ? null : userName,
        "device_mobi": deviceMobi == null ? null : deviceMobi,
        "images": images == null ? null : images,
        "save_account": saveAccount == null ? null : saveAccount
      };
}
