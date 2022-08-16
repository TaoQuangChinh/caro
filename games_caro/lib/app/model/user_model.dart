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
      this.nameGame,
      this.deviceMobi,
      this.images,
      this.saveAccount});

  String? id;
  String? email;
  String? pass;
  String? nameGame;
  String? deviceMobi;
  String? images;
  String? saveAccount;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] == null ? null : json["id"],
      email: json["email"] == null ? null : json["email"],
      pass: json["pass"] == null ? null : json["pass"],
      nameGame: json["nameGame"] == null ? null : json["nameGame"],
      deviceMobi: json["deviceMobi"] == null ? null : json["deviceMobi"],
      images: json["images"] == null || json["images"] == ''
          ? null
          : json["images"],
      saveAccount: json["saveAccount"] == null ? null : json["saveAccount"]);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "pass": pass == null ? null : pass,
        "nameGame": nameGame == null ? null : nameGame,
        "deviceMobi": deviceMobi == null ? null : deviceMobi,
        "images": images == null ? null : images,
        "saveAccount": saveAccount == null ? null : saveAccount
      };
}
