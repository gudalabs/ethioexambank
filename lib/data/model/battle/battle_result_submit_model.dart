// To parse this JSON data, do
//
//     final battleAnswerSubmitModelData = battleAnswerSubmitModelFromJson(jsonString);

import 'dart:convert';

import '../model/message_model/message_model.dart';

BattleAnswerSubmitModel battleAnswerSubmitModelFromJson(String str) => BattleAnswerSubmitModel.fromJson(json.decode(str));

String battleAnswerSubmitModelToJson(BattleAnswerSubmitModel data) => json.encode(data.toJson());

class BattleAnswerSubmitModel {
  final String remark;
  final String status;
  final Message message;
  final Map<String, dynamic> data;

  BattleAnswerSubmitModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory BattleAnswerSubmitModel.fromJson(Map<String, dynamic> json) {
    return BattleAnswerSubmitModel(
      remark: json['remark'],
      status: json['status'],
      message: Message.fromJson(json["message"]),
      data: json['data'] ?? <String, dynamic>{},
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'remark': remark,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
