import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/data/controller/battle/battle_room_quiz_controller.dart';
import 'package:get/get.dart';

import 'battle_player_profile_details.dart';

class BattleQuizUserInfoCard extends StatelessWidget {
  final BattleRoomQuizController quizController;
  const BattleQuizUserInfoCard({
    required this.quizController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        // color: Colors.green,
        margin: const EdgeInsets.all(Dimensions.space10),
        height: Dimensions.space110,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Current User Data
                BattlePlayerProfileDetails(
                    countDownController: quizController.myCountDownController,
                    userData: quizController.battleRoomController
                        .getOpponentUserDetailsOrMy(quizController.battleRepo.apiClient.getUserID(), isMyData: true),
                    quizController: quizController),

                //Opponent Data
                BattlePlayerProfileDetails(
                    countDownController: quizController.opUserCountDownController,
                    userData: quizController.battleRoomController.getOpponentUserDetailsOrMy(
                      quizController.battleRepo.apiClient.getUserID(),
                    ),
                    quizController: quizController),
              ],
            )
          ],
        ),
      );
    });
  }
}
