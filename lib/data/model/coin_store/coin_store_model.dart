
import 'dart:convert';

import '../model/message_model/message_model.dart';

CoinStoreModel coinStoreModelFromJson(String str) => CoinStoreModel.fromJson(json.decode(str));

String coinStoreModelToJson(CoinStoreModel data) => json.encode(data.toJson());

class CoinStoreModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    CoinStoreModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory CoinStoreModel.fromJson(Map<String, dynamic> json) => CoinStoreModel(
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
    List<CoinPlan>? coinPlans;

    Data({
        this.coinPlans,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        coinPlans: json["coinPlans"] == null ? [] : List<CoinPlan>.from(json["coinPlans"]!.map((x) => CoinPlan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "coinPlans": coinPlans == null ? [] : List<dynamic>.from(coinPlans!.map((x) => x.toJson())),
    };
}

class CoinPlan {
    int? id;
    String? title;
    String? image;
    String? coinsAmount;
    String? price;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "coins_amount": coinsAmount,
        "price": price,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}


