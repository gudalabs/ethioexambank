// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

import '../../model/message_model/message_model.dart';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
    String? remark;
    String? status;
    Message? message;

    LogoutModel({
        this.remark,
        this.status,
        this.message,
    });

    factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
        remark: json["remark"],
        status: json["status"].toString(),
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
    };
}
