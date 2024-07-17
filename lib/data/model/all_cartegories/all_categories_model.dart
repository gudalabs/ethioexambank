// To parse this JSON data, do
//
//     final allcategoriesModel = allcategoriesModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

AllCategoriesModel allCategoriesModelFromJson(String str) => AllCategoriesModel.fromJson(json.decode(str));

String allCategoriesModelToJson(AllCategoriesModel data) => json.encode(data.toJson());

class AllCategoriesModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  AllCategoriesModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) => AllCategoriesModel(
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
  List<Category>? categories;
  String? imagePath;

  Data({
    this.categories,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "image_path": imagePath,
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questionsCount;
  String? subcategoriesCount;
  List<QuizInfo>? quizInfos;

  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
    this.subcategoriesCount,
    this.quizInfos,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questionsCount: json["questions_count"].toString(),
        subcategoriesCount: json["subcategories_count"].toString(),
        quizInfos: json["quiz_infos"] == null ? [] : List<QuizInfo>.from(json["quiz_infos"]!.map((x) => QuizInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions_count": questionsCount,
        "subcategories_count": subcategoriesCount,
        "quiz_infos": quizInfos == null ? [] : List<dynamic>.from(quizInfos!.map((x) => x.toJson())),
      };
}

class QuizInfo {
  int? id;
  String? typeId;
  String? categoryId;
  String? subCategoryId;
  dynamic title;
  dynamic image;
  dynamic startDate;
  dynamic endDate;
  dynamic prize;
  dynamic point;
  dynamic description;
  String? levelId;
  String? examStartTime;
  String? examEndTime;
  dynamic examDuration;
  dynamic examKey;
  double? winningMark;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? levelStatus;
  Subcategory? subcategory;
  PlayInfo? playInfo;
  Level? level;

  QuizInfo({
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
    this.levelStatus,
    this.subcategory,
    this.playInfo,
    this.level,
  });

  factory QuizInfo.fromJson(Map<String, dynamic> json) {
    return QuizInfo(
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
      examKey: json["exam_key"].toString(),
      winningMark: double.parse(json["winning_mark"].toString()),
      status: json["status"].toString(),
      createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      levelStatus: json["level_status"].toString(),
      subcategory: json["subcategory"] == null ? null : Subcategory.fromJson(json["subcategory"]),
      playInfo: json["play_info"] == null ? null : PlayInfo.fromJson(json["play_info"]),
      level: json["level"] == null ? null : Level.fromJson(json["level"]),
    );
  }

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
        "level_status": levelStatus,
        "subcategory": subcategory?.toJson(),
        "play_info": playInfo?.toJson(),
        "level": level?.toJson(),
      };
}

class Level {
  int? id;
  String? title;
  String? level;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Level({
    this.id,
    this.title,
    this.level,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        title: json["title"],
        level: json["level"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "level": level,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PlayInfo {
  int? id;
  String? userId;
  String? quizInfoId;
  dynamic roomId;
  dynamic singleBattleId;
  String? isWin;
  String? fiftyFifty;
  String? audiencePoll;
  String? timeReset;
  String? flipQuestion;
  DateTime? createdAt;
  DateTime? updatedAt;

  PlayInfo({
    this.id,
    this.userId,
    this.quizInfoId,
    this.roomId,
    this.singleBattleId,
    this.isWin,
    this.fiftyFifty,
    this.audiencePoll,
    this.timeReset,
    this.flipQuestion,
    this.createdAt,
    this.updatedAt,
  });

  factory PlayInfo.fromJson(Map<String, dynamic> json) => PlayInfo(
        id: json["id"],
        userId: json["user_id"].toString(),
        quizInfoId: json["quiz_info_id"].toString(),
        roomId: json["room_id"].toString(),
        singleBattleId: json["single_battle_id"].toString(),
        isWin: json["is_win"].toString(),
        fiftyFifty: json["fifty_fifty"].toString(),
        audiencePoll: json["audience_poll"].toString(),
        timeReset: json["time_reset"].toString(),
        flipQuestion: json["flip_question"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "quiz_info_id": quizInfoId,
        "room_id": roomId,
        "single_battle_id": singleBattleId,
        "is_win": isWin,
        "fifty_fifty": fiftyFifty,
        "audience_poll": audiencePoll,
        "time_reset": timeReset,
        "flip_question": flipQuestion,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Subcategory {
  int? id;
  String? name;
  String? categoryId;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  Subcategory({
    this.id,
    this.name,
    this.categoryId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"].toString(),
        image: json["image"],
        status: json["status"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
