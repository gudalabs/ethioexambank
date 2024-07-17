// To parse this JSON data, do
//
//     final quizContestListModel = quizContestListModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

QuizContestListModel quizContestListModelFromJson(String str) => QuizContestListModel.fromJson(json.decode(str));

String quizContestListModelToJson(QuizContestListModel data) => json.encode(data.toJson());

class QuizContestListModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    QuizContestListModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory QuizContestListModel.fromJson(Map<String, dynamic> json) => QuizContestListModel(
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
    List<Contest>? contests;
    String? contestImagePath;

    Data({
        this.contests,
        this.contestImagePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        contests: json["contests"] == null ? [] : List<Contest>.from(json["contests"]!.map((x) => Contest.fromJson(x))),
        contestImagePath: json["contest_image_path"],
    );

    Map<String, dynamic> toJson() => {
        "contests": contests == null ? [] : List<dynamic>.from(contests!.map((x) => x.toJson())),
        "contest_image_path": contestImagePath,
    };
}

class Contest {
    int? id;
    String? typeId;
    dynamic categoryId;
    dynamic subCategoryId;
    String? title;
    String? image;
    DateTime? startDate;
    DateTime? endDate;
    String? prize;
    String? point;
    dynamic description;
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

    Contest({
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

    factory Contest.fromJson(Map<String, dynamic> json) => Contest(
        id: json["id"],
        typeId: json["type_id"].toString(),
        categoryId: json["category_id"].toString(),
        subCategoryId: json["sub_category_id"].toString(),
        title: json["title"],
        image: json["image"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
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
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
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
