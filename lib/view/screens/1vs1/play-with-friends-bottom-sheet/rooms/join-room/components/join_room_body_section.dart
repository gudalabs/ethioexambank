import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/otp_field_widget/otp_field_widget.dart';
import 'package:quiz_lab/view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/components/joined_lobby_room_bottom_sheet.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/style.dart';
import '../../../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../../../data/model/battle/battle_question_list.dart';
import '../../../../../../../data/services/api_client.dart';
import '../../../../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../../../../components/buttons/rounded_loading_button.dart';

class JoinRoomBodySection extends StatefulWidget {
  const JoinRoomBodySection({super.key});

  @override
  State<JoinRoomBodySection> createState() => _JoinRoomBodySectionState();
}

class _JoinRoomBodySectionState extends State<JoinRoomBodySection> {
  late TextEditingController joinRoomCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRoomController(Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(builder: (battleRoomController) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: Dimensions.space20, start: Dimensions.space10, end: Dimensions.space10),
            child: Container(
                padding: const EdgeInsetsDirectional.only(top: Dimensions.space8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.space10),
                  color: MyColor.colorWhite,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space12, start: Dimensions.space15),
                      child: Text(
                        MyStrings.entryRoomCode.tr,
                        style: regularMediumLarge.copyWith(color: MyColor.textColor, fontSize: Dimensions.space18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space11),
                      child: OTPFieldWidget(
                        tController: joinRoomCodeController,
                        onChanged: (value) {},
                      ),
                    ),
                    Obx(() {
                      if (battleRoomController.joinRoomState.value != JoinRoomState.none) {
                        if (battleRoomController.joinRoomState.value == JoinRoomState.joined) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            // Navigator.pop(context);
                            if (battleRoomController.battleQuestionsList.isEmpty) {
                              final List<dynamic> existingQuestionsData = json.decode(battleRoomController.battleRoomData.value!.questionsList!);
                              final List<BattleQuestion> existingQuestionsList = existingQuestionsData.map((item) => BattleQuestion.fromJson(item)).toList();

                              battleRoomController.battleQuestionsList.value = existingQuestionsList;
                            }

                            if (battleRoomController.alreadyJoined.value == false) {
                              CustomBottomSheet(
                                enableDrag: false,
                                child: const JoinedLobbyBottomSheet(),
                              ).customBottomSheet(context);
                            }
                            battleRoomController.toogleAlreadyJoined(true);

                            battleRoomController.toogleBattleJoinedState(JoinRoomState.none);
                          });
                        }
                      }
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(start: Dimensions.space15, top: Dimensions.space10, bottom: Dimensions.space25, end: Dimensions.space15),
                        child: battleRoomController.joinRoomState.value == JoinRoomState.joining
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                text: MyStrings.start.tr,
                                press: () async {
                                  await battleRoomController.joinRoom(
                                      name: battleRoomController.battleRepo.apiClient.getUserFullName(), roomCode: joinRoomCodeController.text, profileUrl: battleRoomController.battleRepo.apiClient.getUserImagePath(), uid: battleRoomController.battleRepo.apiClient.getUserID(), currentCoin: battleRoomController.battleRepo.apiClient.getUserCurrentCoin(), joinroom: true);
                                },
                                color: MyColor.primaryColor,
                                textColor: MyColor.colorWhite,
                                textSize: Dimensions.space18,
                                cornerRadius: Dimensions.space10,
                              ),
                      );
                    })
                  ],
                )),
          ),
        ],
      );
    });
  }
}
