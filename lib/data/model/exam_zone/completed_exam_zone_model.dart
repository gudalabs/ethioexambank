// To parse this JSON data, do
//
//     final completedExamListModel = completedExamListModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

CompletedExamListModel completedExamListModelFromJson(String str) => CompletedExamListModel.fromJson(json.decode(str));

String completedExamListModelToJson(CompletedExamListModel data) => json.encode(data.toJson());

class CompletedExamListModel {
    String remark;
    String status;
    Message message;
    Data data;

    CompletedExamListModel({
        required this.remark,
        required this.status,
        required this.message,
        required this.data,
    });

    factory CompletedExamListModel.fromJson(Map<String, dynamic> json) => CompletedExamListModel(
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
    List<CompletedExam> exams;
    String examImagePath;

    Data({
        required this.exams,
        required this.examImagePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        exams: List<CompletedExam>.from(json["exams"].map((x) => CompletedExam.fromJson(x))),
        examImagePath: json["exam_image_path"],
    );

    Map<String, dynamic> toJson() => {
        "exams": List<dynamic>.from(exams.map((x) => x.toJson())),
        "exam_image_path": examImagePath,
    };
}

class CompletedExam {
    int id;
    String typeId;
    dynamic categoryId;
    dynamic subCategoryId;
    String title;
    String? image;
    DateTime startDate;
    DateTime endDate;
    String prize;
    String point;
    String? description;
    dynamic levelId;
    String examStartTime;
    String examEndTime;
    String examDuration;
    String examKey;
    double winningMark;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String questionsCount;
    PlayInfo playInfo;

    CompletedExam({
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
        required this.questionsCount,
        required this.playInfo,
    });

    factory CompletedExam.fromJson(Map<String, dynamic> json) => CompletedExam(
        id: json["id"],
        typeId: json["type_id"].toString(),
        categoryId: json["category_id"].toString(),
        subCategoryId: json["sub_category_id"].toString(),
        title: json["title"],
        image: json["image"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
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
        questionsCount: json["questions_count"].toString(),
        playInfo: PlayInfo.fromJson(json["play_info"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "title": title,
        "image": image,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
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
        "questions_count": questionsCount,
        "play_info": playInfo.toJson(),
    };
}

class PlayInfo {
    int id;
    String userId;
    String quizInfoId;
    dynamic roomId;
    dynamic singleBattleId;
    String isWin;
    String fiftyFifty;
    String audiencePoll;
    String timeReset;
    String flipQuestion;
    DateTime createdAt;
    DateTime updatedAt;
    List<PlayQuestion> playQuestions;

    PlayInfo({
        required this.id,
        required this.userId,
        required this.quizInfoId,
        required this.roomId,
        required this.singleBattleId,
        required this.isWin,
        required this.fiftyFifty,
        required this.audiencePoll,
        required this.timeReset,
        required this.flipQuestion,
        required this.createdAt,
        required this.updatedAt,
        required this.playQuestions,
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        playQuestions: List<PlayQuestion>.from(json["play_questions"].map((x) => PlayQuestion.fromJson(x))),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "play_questions": List<dynamic>.from(playQuestions.map((x) => x.toJson())),
    };
}

class PlayQuestion {
    int id;
    String playInfoId;
    String questionId;
    String userId;
    String isCorrect;
    String optionsId;
    DateTime createdAt;
    DateTime updatedAt;

    PlayQuestion({
        required this.id,
        required this.playInfoId,
        required this.questionId,
        required this.userId,
        required this.isCorrect,
        required this.optionsId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory PlayQuestion.fromJson(Map<String, dynamic> json) => PlayQuestion(
        id: json["id"],
        playInfoId: json["play_info_id"].toString(),
        questionId: json["question_id"].toString(),
        userId: json["user_id"].toString(),
        isCorrect: json["is_correct"].toString(),
        optionsId: json["options_id"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "play_info_id": playInfoId,
        "question_id": questionId,
        "user_id": userId,
        "is_correct": isCorrect,
        "options_id": optionsId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
