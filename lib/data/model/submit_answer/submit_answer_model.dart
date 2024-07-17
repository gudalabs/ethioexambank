// To parse this JSON data, do
//
//     final submitAnswerModel = submitAnswerModelFromJson(jsonString);

import 'dart:convert';
import '../quiz_questions_model/level_model.dart';
import '../model/message_model/message_model.dart';

SubmitAnswerModel submitAnswerModelFromJson(String str) => SubmitAnswerModel.fromJson(json.decode(str));

String submitAnswerModelToJson(SubmitAnswerModel data) => json.encode(data.toJson());

class SubmitAnswerModel {
  String remark;
  String status;
  Message message;
  Data data;

  SubmitAnswerModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory SubmitAnswerModel.fromJson(Map<String, dynamic> json) => SubmitAnswerModel(
        remark: json["remark"],
        status: json["status"].toString(),
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  String totalQuestion;
  String correctAnswer;
  String wrongAnswer;
  String winingScore;
  String totalScore;
  NextLevelQuizInfo? nextLevelQuizInfo;

  Data({
    required this.totalQuestion,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.winingScore,
    required this.totalScore,
    required this.nextLevelQuizInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestion: json["totalQuestion"].toString(),
        correctAnswer: json["correctAnswer"].toString(),
        wrongAnswer: json["wrongAnswer"].toString(),
        winingScore: json["winingScore"].toString(),
        totalScore: json["totalScore"].toString(),
        nextLevelQuizInfo: json["nextLevelQuizInfo"] == null ? null : NextLevelQuizInfo.fromJson(json["nextLevelQuizInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "correctAnswer": correctAnswer,
        "wrongAnswer": wrongAnswer,
        "winingScore": winingScore,
        "totalScore": totalScore,
        "nextLevelQuizInfo": nextLevelQuizInfo!.toJson(),
      };
}

class NextLevelQuizInfo {
  int id;
  String? typeId;
  String? categoryId;
  String? subCategoryId;
  String? title;
  String? image;
  String? startDate;
  String? endDate;
  String? prize;
  String? point;
  String? description;
  String? levelId;
  String? examStartTime;
  String? examEndTime;
  String? examDuration;
  String? examKey;
  double winningMark;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Category? category;
  Category? subcategory;
  Level? level;

  NextLevelQuizInfo({
    required this.id,
    required this.typeId,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.prize,
    required this.point,
    required this.description,
    required this.levelId,
    required this.examStartTime,
    required this.examEndTime,
    required this.examDuration,
    required this.examKey,
    required this.winningMark,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.subcategory,
    required this.level,
  });

  factory NextLevelQuizInfo.fromJson(Map<String, dynamic> json) => NextLevelQuizInfo(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category!.toJson(),
        "subcategory": subcategory!.toJson(),
        "level": level!.toJson(),
      };
}

class Category {
  int id;
  String name;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String? categoryId;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_id": categoryId,
      };
}


