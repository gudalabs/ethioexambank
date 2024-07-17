// To parse this JSON data, do
//
//     final examZoneModel = examZoneModelFromJson(jsonString);

import 'dart:convert';


import 'package:quiz_lab/data/model/exam_zone/exam_zone_question_list_model.dart';

import '../dashboard/exam.dart';
import '../model/message_model/message_model.dart';

ExamZoneModel examZoneModelFromJson(String str) => ExamZoneModel.fromJson(json.decode(str));

String examZoneModelToJson(ExamZoneModel data) => json.encode(data.toJson());

class ExamZoneModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  ExamZoneModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory ExamZoneModel.fromJson(Map<String, dynamic> json) => ExamZoneModel(
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
  List<Exams>? exams;

  Data({
    this.exams,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exams: json["exams"] == null ? [] : List<Exams>.from(json["exams"]!.map((x) => Exams.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
      };
}
