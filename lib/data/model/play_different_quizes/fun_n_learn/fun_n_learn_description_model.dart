// To parse this JSON data, do
//
//     final funNLearnDescriptionModel = funNLearnDescriptionModelFromJson(jsonString);

import 'dart:convert';

import '../../model/message_model/message_model.dart';

FunNLearnDescriptionModel funNLearnDescriptionModelFromJson(String str) => FunNLearnDescriptionModel.fromJson(json.decode(str));

String funNLearnDescriptionModelToJson(FunNLearnDescriptionModel data) => json.encode(data.toJson());

class FunNLearnDescriptionModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  FunNLearnDescriptionModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory FunNLearnDescriptionModel.fromJson(Map<String, dynamic> json) => FunNLearnDescriptionModel(
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
  List<FunList>? funList;

  Data({
    this.funList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        funList: json["funList"] == null ? [] : List<FunList>.from(json["funList"]!.map((x) => FunList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "funList": funList == null ? [] : List<dynamic>.from(funList!.map((x) => x.toJson())),
      };
}

class FunList {
  int? id;
  String? typeId;
  String? categoryId;
  String? subCategoryId;
  String? title;
  dynamic image;
  dynamic startDate;
  dynamic endDate;
  String? prize;
  String? point;
  String? description;
  dynamic levelId;
  String? examStartTime;
  String? examEndTime;
  dynamic examDuration;
  dynamic examKey;
  double? winningMark;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questionsCount;

  FunList({
    this.id,
    this.typeId,
    this.categoryId,
    this.subCategoryId,
    this.title,
    this.image,
    this.startDate,
    this.endDate,
    this.prize,
    this.point,
    this.description,
    this.levelId,
    this.examStartTime,
    this.examEndTime,
    this.examDuration,
    this.examKey,
    this.winningMark,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
  });

  factory FunList.fromJson(Map<String, dynamic> json) => FunList(
        id: json["id"],
        typeId: json["type_id"].toString(),
        categoryId: json["category_id"].toString(),
        subCategoryId: json["sub_category_id"].toString(),
        title: json["title"],
        image: json["image"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        prize: json["prize"].toString(),
        point: json["point"].toString(),
        description: json["description"],
        levelId: json["level_id"].toString(),
        examStartTime: json["exam_start_time"],
        examEndTime: json["exam_end_time"],
        examDuration: json["exam_duration"].toString(),
        examKey: json["exam_key"],
        winningMark: double.parse(json["winning_mark"].toString()),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questionsCount: json["questions_count"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "title": title,
        "image": image,
        "start_date": startDate,
        "end_date": endDate,
        "prize": prize,
        "point": point,
        "description": description,
        "level_id": levelId,
        "exam_start_time": examStartTime,
        "exam_end_time": examEndTime,
        "exam_duration": examDuration,
        "exam_key": examKey,
        "winning_mark": winningMark,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions_count": questionsCount,
      };
}
