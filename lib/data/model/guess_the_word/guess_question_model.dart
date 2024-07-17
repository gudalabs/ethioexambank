// To parse this JSON data, do
//
//     final gesswordQuestionResponse = gesswordQuestionResponseFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:quiz_lab/core/utils/util.dart';

import '../global/meassage.dart';

GuessWordQuestionResponse guessWordQuestionResponseFromJson(String str) => GuessWordQuestionResponse.fromJson(json.decode(str));

String guessWordQuestionResponseToJson(GuessWordQuestionResponse data) => json.encode(data.toJson());

class GuessWordQuestionResponse {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GuessWordQuestionResponse({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GuessWordQuestionResponse.fromJson(Map<String, dynamic> json) => GuessWordQuestionResponse(
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
  QuizInfo? quizInfo;
  List<GuessQuestion>? questions;
  String? perQuestionAnswerDuration;
  String? questionImagePath;

  Data({
    this.quizInfo,
    this.questions,
    this.perQuestionAnswerDuration,
    this.questionImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quizInfo: json["quizInfo"] == null ? null : QuizInfo.fromJson(json["quizInfo"]),
        questions: json["questions"] == null ? [] : List<GuessQuestion>.from(json["questions"]!.map((x) => GuessQuestion.fromJson(x))),
        perQuestionAnswerDuration: json["per_question_answer_duration"].toString(),
        questionImagePath: json["question_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "quizInfo": quizInfo?.toJson(),
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "per_question_answer_duration": perQuestionAnswerDuration,
        "question_image_path": questionImagePath,
      };
}

class GuessQuestion {
  int? id;
  String? question;
  String? image;
  String? code;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;
  String? selectedAnswer;
  List<Option>? options;

  GuessQuestion({this.id, this.question, this.image, this.code, this.status, this.createdAt, this.updatedAt, this.pivot, this.options, this.selectedAnswer});

  factory GuessQuestion.fromJson(Map<String, dynamic> json) => GuessQuestion(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"].toString(),
        status: json["status"].toString(),
        selectedAnswer: '',
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
        'selectedAnswer': selectedAnswer.toString(),
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
      };

  void setSelectedAnswer(String answer) {
    selectedAnswer = answer;
  }
}

class Option {
  int? id;
  String? questionId;
  String? option;
  String? currectAns;
  String? isAnswer;
  String? audience;
  String? createdAt;
  String? updatedAt;

  Option({
    this.id,
    this.questionId,
    this.option,
    this.currectAns,
    this.isAnswer,
    this.audience,
    this.createdAt,
    this.updatedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        questionId: json["question_id"].toString(),
        option: json["option"] == null ? null : MyUtils.shuffleString(json["option"]),
        currectAns: json["option"] == null ? null : json["option"].toString(),
        isAnswer: json["is_answer"].toString(),
        audience: json["audience"].toString(),
        createdAt: json["created_at"] == null ? null : json["created_at"].toString(),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "option": option,
        "is_answer": isAnswer,
        "audience": audience,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
}

class Pivot {
  String? quizInfoId;
  String? questionId;

  Pivot({
    this.quizInfoId,
    this.questionId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        quizInfoId: json["quiz_info_id"].toString(),
        questionId: json["question_id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "quiz_info_id": quizInfoId,
        "question_id": questionId,
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
    this.playInfo,
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
        examKey: json["exam_key"].toString(),
        winningMark: double.parse(json["winning_mark"].toString()),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
