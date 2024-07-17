// To parse this JSON data, do
//
//     final leaderBoardModel = leaderBoardModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

import 'package:get/get.dart';

import '../model/message_model/message_model.dart';

LeaderBoardModel leaderBoardModelFromJson(String str) => LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) => json.encode(data.toJson());

class LeaderBoardModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  LeaderBoardModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) => LeaderBoardModel(
        remark: json["remark"],
        status: json["status"].toString(),
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<User>? user;
  String? userAvatarPath;

  Data({
    this.user,
    this.userAvatarPath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? [] : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
        userAvatarPath: json["user_avatar_path"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? [] : List<dynamic>.from(user!.map((x) => x.toJson())),
        "user_avatar_path": userAvatarPath,
      };
}

class User {
  String username;
  String? firstname;
  String? lastname;
  String score;
  String? avatar;
  String userRank;

  User({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.score,
    required this.avatar,
    required this.userRank,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        score: json["score"] != null? json["score"].toString() : '00',
        avatar: json["avatar"],
        userRank: json["user_rank"] != null? json["user_rank"].toString() : "",
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "score": score,
        "avatar": avatar,
        "user_rank": userRank,
      };
  // Computed property for full name
  String get fullName {
    if (firstname != null && lastname != null) {
      return "$firstname $lastname";
    } else if (firstname != null) {
      return firstname!;
    } else if (lastname != null) {
      return lastname!;
    } else {
      return "";
    }
  }
}
