// To parse this JSON data, do
//
//     final battleQuestionList = battleQuestionListFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

BattleQuestionList battleQuestionListFromJson(String str) => BattleQuestionList.fromJson(json.decode(str));

String battleQuestionListToJson(BattleQuestionList data) => json.encode(data.toJson());

class BattleQuestionList {
    String remark;
    String status;
    Message message;
    Data data;

    BattleQuestionList({
        required this.remark,
        required this.status,
        required this.message,
        required this.data,
    });

    factory BattleQuestionList.fromJson(Map<String, dynamic> json) => BattleQuestionList(
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
    List<BattleQuestion> questions;
    String questionImagePath;

    Data({
        required this.questions,
        required this.questionImagePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        questions: List<BattleQuestion>.from(json["questions"].map((x) => BattleQuestion.fromJson(x))),
        questionImagePath: json["question_image_path"],
    );

    Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "question_image_path": questionImagePath,
    };
}

class BattleQuestion {
    int id;
    String question;
    dynamic image;
    String code;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    List<BattleQuestionOption> options;

    BattleQuestion({
        required this.id,
        required this.question,
        required this.image,
        required this.code,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.options,
    });

    factory BattleQuestion.fromJson(Map<String, dynamic> json) => BattleQuestion(
        id: json["id"],
        question: json["question"],
        image: json["image"],
        code: json["code"].toString(),
        status: json["status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options: List<BattleQuestionOption>.from(json["options"].map((x) => BattleQuestionOption.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "image": image,
        "code": code,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
    };
}

class BattleQuestionOption {
    int id;
    String questionId;
    String option;
    String isAnswer;
    String? audience;
    DateTime createdAt;
    DateTime updatedAt;

    BattleQuestionOption({
        required this.id,
        required this.questionId,
        required this.option,
        required this.isAnswer,
        required this.audience,
        required this.createdAt,
        required this.updatedAt,
    });

    factory BattleQuestionOption.fromJson(Map<String, dynamic> json) => BattleQuestionOption(
        id: json["id"],
        questionId: json["question_id"].toString(),
        option: json["option"],
        isAnswer: json["is_answer"].toString(),
        audience: json["audience"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "option": option,
        "is_answer": isAnswer,
        "audience": audience,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}


