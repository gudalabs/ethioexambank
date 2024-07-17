// To parse this JSON data, do
//
//     final examZoneQuestionsModel = examZoneQuestionsModelFromJson(jsonString);

import 'dart:convert';

import '../dashboard/exam.dart';
import '../model/message_model/message_model.dart';

ExamZoneQuestionsModel examZoneQuestionsModelFromJson(String str) => ExamZoneQuestionsModel.fromJson(json.decode(str));

String examZoneQuestionsModelToJson(ExamZoneQuestionsModel data) => json.encode(data.toJson());

class ExamZoneQuestionsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  ExamZoneQuestionsModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory ExamZoneQuestionsModel.fromJson(Map<String, dynamic> json) => ExamZoneQuestionsModel(
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
  Exams? exam;
  List<Question>? questions;
  String? examImagePath;
  String? questionImagePath;

  Data({
    this.exam,
    this.questions,
    this.examImagePath,
    this.questionImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        exam: json["exam"] == null ? null : Exams.fromJson(json["exam"]),
        questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
        examImagePath: json["exam_image_path"],
        questionImagePath: json["question_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "exam": exam?.toJson(),
        "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "exam_image_path": examImagePath,
        "question_image_path": questionImagePath,
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

class Question {
  int? id;
  String? question;
  dynamic image;
  String? code;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? selectedOptionId;
  Pivot? pivot;
  List<Option>? options;

  Question({
    this.id,
    this.question,
    this.image,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.selectedOptionId = '',
    this.pivot,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        selectedOptionId: '',
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "status": status,
        "selectedIndex": selectedOptionId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
  void setSelectedOptionId(String optionId) {
    selectedOptionId = optionId;
  }
}

class Option {
  int? id;
  String? questionId;
  String? option;
  String? isAnswer;
  String? audience;
  DateTime? createdAt;
  DateTime? updatedAt;

  Option({
    this.id,
    this.questionId,
    this.option,
    this.isAnswer,
    this.audience,
    this.createdAt,
    this.updatedAt,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        questionId: json["question_id"].toString(),
        option: json["option"],
        isAnswer: json["is_answer"].toString(),
        audience: json["audience"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "option": option,
        "is_answer": isAnswer,
        "audience": audience,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
