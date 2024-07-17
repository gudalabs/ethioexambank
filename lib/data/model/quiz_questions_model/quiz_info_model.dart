import 'level_model.dart';
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
  dynamic playInfo;
  String? levelStatus;
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
    this.playInfo,
    this.levelStatus,
    this.level,
  });

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
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
    playInfo: json["play_info"] == null ? null : PlayInfo.fromJson(json["play_info"]),
    levelStatus: json["level_status"].toString(),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "play_info": playInfo,
    "level": level?.toJson(),
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
    isWin:json["is_win"].toString(),
    fiftyFifty: json["fifty_fifty"].toString(),
    audiencePoll:json["audience_poll"].toString(),
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

