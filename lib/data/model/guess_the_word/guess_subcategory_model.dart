// To parse this JSON data, do
//
//     final gesswordSubCategoryResponse = gesswordSubCategoryResponseFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:quiz_lab/data/model/global/meassage.dart';

GuessWordSubCategoryResponse gesswordSubCategoryResponseFromJson(String str) => GuessWordSubCategoryResponse.fromJson(json.decode(str));

String guessWordSubCategoryResponseToJson(GuessWordSubCategoryResponse data) => json.encode(data.toJson());

class GuessWordSubCategoryResponse {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GuessWordSubCategoryResponse({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GuessWordSubCategoryResponse.fromJson(Map<String, dynamic> json) => GuessWordSubCategoryResponse(
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
  List<GuessSubCategory>? subcategories;
  String? imgPath;

  Data({
    this.subcategories,
    this.imgPath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imgPath: json["subcategory_image_path"].toString(),
        subcategories: json["subcategories"] == null ? [] : List<GuessSubCategory>.from(json["subcategories"]!.map((x) => GuessSubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
      };
}

class GuessSubCategory {
  int? id;
  String? name;
  String? categoryId;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? questionsCount;
  List<QuizInfo>? quizInfos;

  GuessSubCategory({
    this.id,
    this.name,
    this.categoryId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
    this.quizInfos,
  });

  factory GuessSubCategory.fromJson(Map<String, dynamic> json) => GuessSubCategory(
        id: json["id"],
        name: json["name"] == null ? null : json["name"].toString(),
        categoryId: json["category_id"].toString(),
        image: json["image"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
        questionsCount: json["questions_count"].toString(),
        quizInfos: json["quiz_infos"] == null ? [] : List<QuizInfo>.from(json["quiz_infos"]!.map((x) => QuizInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "image": image,
        "status": status,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "questions_count": questionsCount,
        "quiz_infos": quizInfos == null ? [] : List<dynamic>.from(quizInfos!.map((x) => x.toJson())),
      };
}

class QuizInfo {
  int? id;
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
  String? winningMark;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? levelStatus;
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
    this.playInfo,
    this.level,
  });

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
      id: json["id"],
      typeId: json["type_id"] == null ? '' : json["type_id"].toString(),
      categoryId: json["category_id"] == null ? null : json["category_id"].toString(),
      subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"].toString(),
      title: json["title"] == null ? '' : json["title"].toString(),
      image: json["image"] == null ? '' : json["image"].toString(),
      startDate: json["start_date"] == null ? '' : json["start_date"].toString(),
      endDate: json["end_date"] == null ? '' : json["end_date"].toString(),
      prize: json["prize"] == null ? '' : json["end_date"].toString(),
      point: json["point"] == null ? '' : json["end_date"].toString(),
      description: json["description"] == null ? '' : json["description"].toString(),
      levelId: json["level_id"] == null ? '' : json["level_id"].toString(),
      examStartTime: json["exam_start_time"] == null ? '' : json["exam_start_time"].toString(),
      examEndTime: json["exam_end_time"] == null ? '' : json["exam_end_time"].toString(),
      examDuration: json["exam_duration"] == null ? '' : json["exam_duration"].toString(),
      examKey: json["exam_key"] == null ? '' : json["exam_key"].toString(),
      winningMark: json["winning_mark"] == null ? '' : json["winning_mark"].toString(),
      status: json["status"] == null ? '' : json["status"].toString(),
      createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
      levelStatus: json["level_status"],
      updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
      playInfo: json["play_info"] == null ? null : PlayInfo.fromJson(json["play_info"]),
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
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "level_status": levelStatus,
        "play_info": playInfo?.toJson(),
        "level": level?.toJson(),
      };
}

class Level {
  int? id;
  String? title;
  String? level;
  String? status;
  String? createdAt;
  String? updatedAt;

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
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "level": level,
        "status": status,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
}

class PlayInfo {
  int? id;
  String? userId;
  String? quizInfoId;
  String? roomId;
  String? singleBattleId;
  String? isWin;
  String? fiftyFifty;
  String? audiencePoll;
  String? timeReset;
  String? flipQuestion;
  String? createdAt;
  String? updatedAt;

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
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
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
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
}
