// To parse this JSON data, do
//
//     final examResultModel = examResultModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

ExamResultModel examResultModelFromJson(String str) => ExamResultModel.fromJson(json.decode(str));

String examResultModelToJson(ExamResultModel data) => json.encode(data.toJson());

class ExamResultModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    ExamResultModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory ExamResultModel.fromJson(Map<String, dynamic> json) => ExamResultModel(
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
    String? totalQuestion;
    String? correctAnswer;
    String? wrongAnswer;
    String? winingCoin;
    String? totalCoin;

    Data({
        this.totalQuestion,
        this.correctAnswer,
        this.wrongAnswer,
        this.winingCoin,
        this.totalCoin,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestion: json["totalQuestion"].toString(),
        correctAnswer: json["correctAnswer"].toString(),
        wrongAnswer: json["wrongAnswer"].toString(),
        winingCoin: json["winingCoin"].toString(),
        totalCoin: json["totalCoin"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "correctAnswer": correctAnswer,
        "wrongAnswer": wrongAnswer,
        "winingCoin": winingCoin,
        "totalCoin": totalCoin,
    };
}


