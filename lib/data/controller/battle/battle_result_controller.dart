import 'package:confetti/confetti.dart';
import 'package:quiz_lab/data/repo/battle/battle_repo.dart';
import 'package:get/get.dart';

import '../../model/battle/battle_room_data_model.dart';
import '../../model/battle/battle_result_submit_model.dart';

class BattleResultController extends GetxController {
  final BattleRepo battleRepo;
  BattleResultController(this.battleRepo);

  //Animations
  late ConfettiController _controllerTopCenter;
  ConfettiController get confettiControllerTopCenter => _controllerTopCenter;
  // Variables

  final argumentsResult = Get.arguments[0] as BattleAnswerSubmitModel;
  List get messageStatus => [...argumentsResult.message.success!, ...argumentsResult.message.error!];
  String get totalQuestion => argumentsResult.data["totalQuestion"].toString();
  String get correctAnswer => argumentsResult.data["correctAnswer"].toString();
  String get opponentCorrectAnswer => argumentsResult.data["opponent_correct_ans"].toString();
  String get wrongAnswer => argumentsResult.data["wrongAnswer"].toString();
  Map get opponentData => argumentsResult.data["opponent"];
  Map get myUserInfoData => battleRepo.apiClient.getUserData();
  final battleRoomOldData = Get.arguments[1] as BattleRoomDataModel;

  //Methods
  @override
  void onInit() {
    super.onInit();
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void onClose() {
    super.onClose();
    _controllerTopCenter.dispose();
  }
}
