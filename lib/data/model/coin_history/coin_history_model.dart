
import 'dart:convert';

import '../model/message_model/message_model.dart';

CoinHistoryModel coinHistoryModelFromJson(String str) => CoinHistoryModel.fromJson(json.decode(str));

String coinHistoryModelToJson(CoinHistoryModel data) => json.encode(data.toJson());

class CoinHistoryModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  CoinHistoryModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory CoinHistoryModel.fromJson(Map<String, dynamic> json) => CoinHistoryModel(
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
  List<CoinLog>? coinLogs;

  Data({
    this.coinLogs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        coinLogs: json["coinLogs"] == null ? [] : List<CoinLog>.from(json["coinLogs"]!.map((x) => CoinLog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coinLogs": coinLogs == null ? [] : List<dynamic>.from(coinLogs!.map((x) => x.toJson())),
      };
}

class CoinLog {
  int? id;
  String? userId;
  String? quizInfoId;
  String? coinPlanId;
  String? coins;
  String? status;
  DateTime? createdAt;
  String? updatedAt;
  CoinPlan? coinPlan;

  CoinLog({
    this.id,
    this.userId,
    this.quizInfoId,
    this.coinPlanId,
    this.coins,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.coinPlan,
  });

  factory CoinLog.fromJson(Map<String, dynamic> json) => CoinLog(
        id: json["id"],
        userId: json["user_id"].toString(),
        quizInfoId: json["quiz_info_id"].toString(),
        coinPlanId: json["coin_plan_id"].toString(),
        coins: json["coins"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        coinPlan: json["coin_plan"] == null ? null : CoinPlan.fromJson(json["coin_plan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "quiz_info_id": quizInfoId,
        "coin_plan_id": coinPlanId,
        "coins": coins,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "coin_plan": coinPlan?.toJson(),
      };
}

class CoinPlan {
  int? id;
  String? title;
  String? image;
  String? coinsAmount;
  String? price;
  String? status;
  String? createdAt;
  String? updatedAt;

  CoinPlan({
    this.id,
    this.title,
    this.image,
    this.coinsAmount,
    this.price,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CoinPlan.fromJson(Map<String, dynamic> json) => CoinPlan(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        coinsAmount: json["coins_amount"].toString(),
        price: json["price"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "coins_amount": coinsAmount,
        "price": price,
        "status": status,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
      };
}
