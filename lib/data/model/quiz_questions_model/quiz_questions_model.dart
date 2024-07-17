// To parse this JSON data, do
//
//     final quizquestionsModel = quizquestionsModelFromJson(jsonString);

import 'dart:convert';

import '../all_cartegories/all_categories_model.dart';
import '../model/message_model/message_model.dart';

QuizQuestionsModel quizQuestionsModelFromJson(String str) => QuizQuestionsModel.fromJson(json.decode(str));

String quizQuestionsModelToJson(QuizQuestionsModel data) => json.encode(data.toJson());

class QuizQuestionsModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  QuizQuestionsModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory QuizQuestionsModel.fromJson(Map<String, dynamic> json) => QuizQuestionsModel(
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
  List<Question>? questions;
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
        questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
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

class Question {
  int? id;
  String? question;
  dynamic image;
  String? code;
  String? playedAudience;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;
  String? selectedOptionId;
  List<Option>? options;

  Question({this.id, this.question, this.image, this.code, this.playedAudience, this.status, this.createdAt, this.updatedAt, this.pivot, this.options, this.selectedOptionId = ''});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"],
        playedAudience: json["played_audience"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        selectedOptionId: '',
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "played_audience": playedAudience,
        "status": status,
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
  dynamic audience;
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


