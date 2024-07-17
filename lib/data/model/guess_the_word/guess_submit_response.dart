
import 'package:quiz_lab/data/model/global/meassage.dart';

class GuessWordQuestionSubmitResponse {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GuessWordQuestionSubmitResponse({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GuessWordQuestionSubmitResponse.fromJson(Map<String, dynamic> json) => GuessWordQuestionSubmitResponse(
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
  String? totalQuestion;
  String? correctAnswer;
  String? wrongAnswer;
  String? winingScore;
  String? totalScore;

  Data({
    this.totalQuestion,
    this.correctAnswer,
    this.wrongAnswer,
    this.winingScore,
    this.totalScore,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestion: json["totalQuestion"] != null ? json['totalQuestion'].toString() : '',
        correctAnswer: json["correctAnswer"] != null ? json['correctAnswer'].toString() : '',
        wrongAnswer: json["wrongAnswer"] != null ? json['wrongAnswer'].toString() : '',
        winingScore: json["winingScore"] != null ? json['winingScore'].toString() : '',
        totalScore: json["totalScore"] != null ? json['totalScore'].toString() : '',
      );

  Map<String, dynamic> toJson() => {
        "totalQuestion": totalQuestion,
        "correctAnswer": correctAnswer,
        "wrongAnswer": wrongAnswer,
        "winingScore": winingScore,
        "totalScore": totalScore,
      };
}
