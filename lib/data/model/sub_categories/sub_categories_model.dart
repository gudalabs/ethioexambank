// To parse this JSON data, do
//
//     final subcategoriesModel = subcategoriesModelFromJson(jsonString);

import 'dart:convert';
import '../model/message_model/message_model.dart';
import '../quiz_questions_model/quiz_info_model.dart';

SubcategoriesModel subcategoriesModelFromJson(String str) => SubcategoriesModel.fromJson(json.decode(str));

String subcategoriesModelToJson(SubcategoriesModel data) => json.encode(data.toJson());

class SubcategoriesModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SubcategoriesModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory SubcategoriesModel.fromJson(Map<String, dynamic> json) => SubcategoriesModel(
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
  Category? category;
  List<Subcategory>? subcategories;
  String? subcategoryImagePath;
  String? categoryImagePath;

  Data({
    this.category,
    this.subcategories,
    this.subcategoryImagePath,
    this.categoryImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
        subcategoryImagePath: json["subcategory_image_path"],
        categoryImagePath: json["category_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
        "subcategory_image_path": subcategoryImagePath,
        "category_image_path": categoryImagePath,
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Subcategory {
  int? id;
  String? name;
  String? categoryId;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questionsCount;
  List<QuizInfo>? quizInfos;

  Subcategory({
    this.id,
    this.name,
    this.categoryId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
    this.quizInfos,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"].toString(),
        image: json["image"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questionsCount: json["questions_count"].toString(),
        quizInfos: json["quiz_infos"] == null ? [] : List<QuizInfo>.from(json["quiz_infos"]!.map((x) => QuizInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions_count": questionsCount,
        "quiz_infos": quizInfos == null ? [] : List<dynamic>.from(quizInfos!.map((x) => x.toJson())),
      };
}


