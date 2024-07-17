
import 'dart:convert';

AppLanguageResponseModel appLanguageResponseModelFromJson(String str) => AppLanguageResponseModel.fromJson(json.decode(str));

String appLanguageResponseModelToJson(AppLanguageResponseModel data) => json.encode(data.toJson());

class AppLanguageResponseModel {
    String remark;
    String status;
    Message message;
    Data data;

    AppLanguageResponseModel({
        required this.remark,
        required this.status,
        required this.message,
        required this.data,
    });

    factory AppLanguageResponseModel.fromJson(Map<String, dynamic> json) => AppLanguageResponseModel(
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
    Map<String, String> languageData;
    List<Language> languages;

    Data({
        required this.languageData,
        required this.languages,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        languageData: Map.from(json["language_data"]).map((k, v) => MapEntry<String, String>(k, v)),
        languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "language_data": Map.from(languageData).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    };
}

class Language {
    int id;
    String name;
    String code;
    String isDefault;
    DateTime createdAt;
    DateTime updatedAt;

    Language({
        required this.id,
        required this.name,
        required this.code,
        required this.isDefault,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        isDefault: json["is_default"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "is_default": isDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Message {
    List<String> success;

    Message({
        required this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
    };
}
