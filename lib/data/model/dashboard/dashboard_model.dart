
import 'dart:convert';

import '../model/message_model/message_model.dart';
import 'exam.dart';

DashBoardModel dashBoardModelFromJson(String str) => DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  DashBoardModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
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
  User? user;
  Rank? rank;
  List<QuizType>? quizType;
  List<Category>? categories;
  List<Contest>? contest;
  List<Exams>? exams;
  String? categoryImagePath;
  String? contestImagePath;
  String? quizImagePath;
  String? examImagePath;
  String? userImagePath;
  String? generalQuizStatus;
  String? contestStatus;
  String? funNLearnStatus;
  String? guessTheWordStatus;
  String? examStatus;
  String? dailyQuizStatus;
  String? singleBattleStatus;
  Data({
    this.user,
    this.rank,
    this.quizType,
    this.categories,
    this.contest,
    this.exams,
    this.categoryImagePath,
    this.contestImagePath,
    this.quizImagePath,
    this.examImagePath,
    this.userImagePath,
    this.generalQuizStatus,
    this.contestStatus,
    this.funNLearnStatus,
    this.guessTheWordStatus,
    this.examStatus,
    this.dailyQuizStatus,
    this.singleBattleStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      rank: json["rank"] == null ? null : Rank.fromJson(json["rank"]),
      quizType: json["quiz_type"] == null ? [] : List<QuizType>.from(json["quiz_type"]!.map((x) => QuizType.fromJson(x))),
      categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
      contest: json["contest"] == null ? [] : List<Contest>.from(json["contest"]!.map((x) => Contest.fromJson(x))),
      exams: json["exams"] == null ? [] : List<Exams>.from(json["exams"]!.map((x) => Exams.fromJson(x))),
      categoryImagePath: json["category_image_path"],
      contestImagePath: json["contest_image_path"],
      quizImagePath: json["quiz_image_path"],
      examImagePath: json["exam_image_path"],
      userImagePath: json["user_image_path"],
      generalQuizStatus: json["general_quiz_status"].toString(),
      contestStatus: json["contest_status"].toString(),
      funNLearnStatus: json["fun_n_learn_status"].toString(),
      guessTheWordStatus: json["guess_the_word_status"].toString(),
      examStatus: json["exam_status"].toString(),
      dailyQuizStatus: json["daily_quiz_status"].toString(),
      singleBattleStatus: json["single_battle_status"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "rank": rank?.toJson(),
        "quiz_type": quizType == null ? [] : List<dynamic>.from(quizType!.map((x) => x.toJson())),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "contest": contest == null ? [] : List<dynamic>.from(contest!.map((x) => x.toJson())),
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
        "category_image_path": categoryImagePath,
        "contest_image_path": contestImagePath,
        "quiz_image_path": quizImagePath,
        "exam_image_path": examImagePath,
        "user_image_path": userImagePath,
        "general_quiz_status": generalQuizStatus,
        "contest_status": contestStatus,
        "fun_n_learn_status": funNLearnStatus,
        "guess_the_word_status": guessTheWordStatus,
        "exam_status": examStatus,
        "daily_quiz_status": dailyQuizStatus,
        "single_battle_status": singleBattleStatus,
      };
}

class Category {
  int? id;
  String? name;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questionsCount;

  Category({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.questionsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        questionsCount: json["questions_count"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "questions_count": questionsCount,
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
  String? endDate;
  String? prize;
  String? point;
  dynamic description;
  dynamic levelId;
  String? examStartTime;
  String? examEndTime;
  String? examDuration;
  String? examKey;
  dynamic enrolledPlayer;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

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
    this.enrolledPlayer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
        id: json["id"],
        typeId: json["type_id"].toString(),
        categoryId: json["category_id"].toString(),
        subCategoryId: json["sub_category_id"].toString(),
        title: json["title"],
        image: json["image"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        prize: json["prize"].toString(),
        point: json["point"].toString(),
        description: json["description"] ?? "",
        levelId: json["level_id"].toString(),
        examStartTime: json["exam_start_time"],
        examEndTime: json["exam_end_time"],
        examDuration: json["exam_duration"].toString(),
        examKey: json["exam_key"].toString(),
        enrolledPlayer: json["enrolled_player"],
        status: json["status"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "title": title,
        "image": image,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.toString().padLeft(4, '0')}-${endDate!.toString().padLeft(2, '0')}-${endDate!.toString().padLeft(2, '0')}",
        "prize": prize,
        "point": point,
        "description": description,
        "level_id": levelId,
        "exam_start_time": examStartTime,
        "exam_end_time": examEndTime,
        "exam_duration": examDuration,
        "exam_key": examKey,
        "enrolled_player": enrolledPlayer,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}



class QuizType {
  int? id;
  String? name;
  String? act;
  String? image;
  String? isCategorise;
  String? status;
  String? shortDescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuizType({
    this.id,
    this.name,
    this.act,
    this.image,
    this.isCategorise,
    this.status,
    this.shortDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory QuizType.fromJson(Map<String, dynamic> json) => QuizType(
        id: json["id"],
        name: json["name"],
        act: json["act"],
        image: json["image"] ?? "",
        isCategorise: json["is_categorise"].toString(),
        status: json["status"].toString(),
        shortDescription: json["short_description"] ?? "",
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "act": act,
        "image": image,
        "is_categorise": isCategorise,
        "status": status,
        "short_description": shortDescription,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Rank {
  String? userRank;

  Rank({
    this.userRank,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        userRank: json["user_rank"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_rank": userRank,
      };
}

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? avatar;
  String? email;
  String? countryCode;
  String? mobile;
  String? refBy;
  dynamic referralCode;
  Address? address;
  String? status;
  String? kv;
  String? ev;
  String? sv;
  String? profileComplete;
  DateTime? verCodeSendAt;
  String? ts;
  String? tv;
  dynamic tsc;
  dynamic banReason;
  String? coins;
  String? score;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.avatar,
    this.email,
    this.countryCode,
    this.mobile,
    this.refBy,
    this.referralCode,
    this.address,
    this.status,
    this.kv,
    this.ev,
    this.sv,
    this.profileComplete,
    this.verCodeSendAt,
    this.ts,
    this.tv,
    this.tsc,
    this.banReason,
    this.coins,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        avatar: json["avatar"],
        email: json["email"],
        countryCode: json["country_code"].toString(),
        mobile: json["mobile"],
        refBy: json["ref_by"].toString(),
        referralCode: json["referral_code"].toString(),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        status: json["status"].toString(),
        kv: json["kv"].toString(),
        ev: json["ev"].toString(),
        sv: json["sv"].toString(),
        profileComplete: json["profile_complete"].toString(),
        verCodeSendAt: json["ver_code_send_at"] == null ? null : DateTime.parse(json["ver_code_send_at"]),
        ts: json["ts"].toString(),
        tv: json["tv"].toString(),
        tsc: json["tsc"].toString(),
        banReason: json["ban_reason"].toString(),
        coins: json["coins"].toString(),
        score: json["score"].toString(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "avatar": avatar,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "ref_by": refBy,
        "referral_code": referralCode,
        "address": address?.toJson(),
        "status": status,
        "kv": kv,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code_send_at": verCodeSendAt?.toIso8601String(),
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "coins": coins,
        "score": score,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Address {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"] ,
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
      };
}
