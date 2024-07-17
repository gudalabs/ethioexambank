// To parse this JSON data, do
//
//     final funSubCategoryListModel = funSubCategoryListModelFromJson(jsonString);

import 'dart:convert';

import '../../model/message_model/message_model.dart';

FunSubCategoryListModel funSubCategoryListModelFromJson(String str) => FunSubCategoryListModel.fromJson(json.decode(str));

String funSubCategoryListModelToJson(FunSubCategoryListModel data) => json.encode(data.toJson());

class FunSubCategoryListModel {
  String remark;
  String status;
  Message message;
  Data? data;

  FunSubCategoryListModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory FunSubCategoryListModel.fromJson(Map<String, dynamic> json) => FunSubCategoryListModel(
        remark: json["remark"],
        status: json["status"].toString(),
        message: Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<Subcategory> subcategories;

  Data({
    required this.subcategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}

class Subcategory {
  int id;
  String name;
  String categoryId;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String quizInfosCount;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.quizInfosCount,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"].toString(),
        image: json["image"],
        status: json["status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        quizInfosCount: json["quiz_infos_count"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "quiz_infos_count": quizInfosCount,
      };
}
