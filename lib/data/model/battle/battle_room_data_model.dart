import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_lab/data/model/battle/user_battle_room_details_model.dart';

class BattleRoomDataModel {
  final String? roomId;
  final String? categoryId;
  final String? createdBy;

  final UserBattleRoomDetailsModel? user1;
  final UserBattleRoomDetailsModel? user2;
  final UserBattleRoomDetailsModel? user3;
  final UserBattleRoomDetailsModel? user4;
  final String? entryFee;
  final String? roomCode;
  final bool? readyToPlay;
  final String? questionsList;

  BattleRoomDataModel({this.roomId, this.categoryId, this.user1, this.user2, this.createdBy, this.readyToPlay, this.roomCode, this.user3, this.user4, this.entryFee, this.questionsList});

  static BattleRoomDataModel fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return BattleRoomDataModel(
        roomId: documentSnapshot.id,
        categoryId: data['categoryId'] == null ? "" : data['categoryId'].toString() ,
        createdBy: data['createdBy'],
        readyToPlay: data['readyToPlay'] ?? false,
        entryFee: data['entryFee'] != null ?  data['entryFee'].toString() : "0",
        roomCode: data['roomCode'] ?? "",
        user1: UserBattleRoomDetailsModel.fromJson(Map.from(data['user1'])),
        user2: UserBattleRoomDetailsModel.fromJson(Map.from(data['user2'])),
        user3: UserBattleRoomDetailsModel.fromJson(Map.from(data['user3'] ?? {})),
        user4: UserBattleRoomDetailsModel.fromJson(Map.from(data['user4'] ?? {})),
        questionsList: data["questions_list"]);
  }

  BattleRoomDataModel copyWih({String? categoryId}) {
    return BattleRoomDataModel(
      roomId: roomId,
      categoryId: categoryId ?? this.categoryId,
      createdBy: createdBy,
      user1: user1,
      user2: user2,
      questionsList: questionsList,
    );
  }
}
