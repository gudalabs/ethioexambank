import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/repo/battle/battle_repo.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../core/utils/url_container.dart';
import '../../../../../data/controller/battle/battle_room_controller.dart';
import '../../../../../data/services/api_client.dart';
import '../../../../components/alert-dialog/custom_alert_dialog.dart';
import '../../../../components/dialog/warning_dialog.dart';
import '../../../../components/image_widget/my_image_widget.dart';
import '../../../../components/text/default_text.dart';
import '../../../../../data/controller/battle/find_opponents_controller.dart';

class FindOpponentsBodySection extends StatefulWidget {
  const FindOpponentsBodySection({super.key});

  @override
  State<FindOpponentsBodySection> createState() => _FindOpponentsBodySectionState();
}

class _FindOpponentsBodySectionState extends State<FindOpponentsBodySection> {
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRepo(apiClient: Get.find()));
    Get.put(BattleRoomController(Get.find()));
    Get.put(FindOpponentsController(Get.find(), Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindOpponentsController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          const WarningAlertDialog().warningAlertDialog(
            context,
            () async {
              if (controller.battleRoomController.battleRoomData.value != null) {
                await controller.battleRoomController.deleteBattleRoom(controller.battleRoomController.battleRoomData.value!.roomId, false).whenComplete(() {
                  Navigator.of(context).pop(true);
                  // Return true when "Yes" is pressed
                  Get.back();
                });
              } else {
                Navigator.of(context).pop(true);
                // Return true when "Yes" is pressed
                Get.back();
              }
            },
            title: MyStrings.areYouSureYouWantToCloseSearching,
          );

          return false; // Disable back button if `start` is true
        },
        child: Column(
          children: [
            const SizedBox(height: Dimensions.space70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Dimensions.space2),
                      height: Dimensions.space100,
                      width: Dimensions.space100,
                      decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.space100),
                            child: controller.battleRepo.apiClient.getUserImagePath() == "null" || controller.battleRepo.apiClient.getUserImagePath().isEmpty
                                ? Image.asset(
                                    MyImages.defaultAvatar,
                                    fit: BoxFit.cover,
                                    height: Dimensions.space50,
                                    width: Dimensions.space50,
                                  )
                                : MyImageWidget(
                                    fromProfile: true,
                                    imageUrl:"${UrlContainer.userImagePath}/${controller.battleRepo.apiClient.getUserImagePath()}",
                                    height: Dimensions.space50,
                                    width: Dimensions.space50,
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.space10,
                    ),
                    Text(
                      "${controller.battleRepo.apiClient.getUserFullName()}  ",
                      style: semiBoldLarge,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space20),
                  child: Text(
                    MyStrings.vs.tr,
                    style: semiBoldOverLarge.copyWith(color: MyColor.colorBlack),
                  ),
                ),
                Obx(() {
                  var opUserData = controller.battleRoomController.getOpponentUserDetailsOrMy(controller.battleRepo.apiClient.getUserID());

                  if (controller.battleRoomController.userFoundState.value == UserFoundState.found) {
                    controller.imageScrollController.stop();
                  }
                  return controller.battleRoomController.userFoundState.value == UserFoundState.found
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(Dimensions.space2),
                              height: Dimensions.space100,
                              width: Dimensions.space100,
                              decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.space100),
                                    child: opUserData.profileUrl == "null" || opUserData.profileUrl.isEmpty
                                        ? Image.asset(
                                            MyImages.defaultAvatar,
                                            fit: BoxFit.cover,
                                            height: Dimensions.space50,
                                            width: Dimensions.space50,
                                          )
                                        : MyImageWidget(
                                            fromProfile: true,
                                            imageUrl:"${UrlContainer.userImagePath}/${opUserData.profileUrl}",
                                            height: Dimensions.space50,
                                            width: Dimensions.space50,
                                          )),
                              ),
                            ),
                            const SizedBox(
                              height: Dimensions.space10,
                            ),
                            Text(
                              "${opUserData.name} ",
                              style: semiBoldLarge,
                            )
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(Dimensions.space2),
                                height: Dimensions.space100,
                                width: Dimensions.space100,
                                decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.space100),
                                      child: Image.asset(
                                        MyImages.defaultAvatar,
                                        fit: BoxFit.cover,
                                        height: Dimensions.space50,
                                        width: Dimensions.space50,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.space10,
                              ),
                              Text(
                                "${MyStrings.searching.tr}...",
                                style: semiBoldLarge,
                              )
                            ],
                          ),
                        );
                }),
              ],
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space15, end: Dimensions.space15, bottom: Dimensions.space20),
                  width: double.infinity,
                  child: Lottie.asset(
                    MyImages.userSearchLottie,
                    height: Get.width / 1.5,
                    controller: controller.imageScrollController,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      controller.imageScrollController
                        ..duration = composition.duration
                        ..repeat();
                    },
                  ),
                ),
                Obx(() => controller.battleRoomController.userFoundState.value == UserFoundState.found
                    ? Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          color: MyColor.scaffoldBackgroundColor.withOpacity(0.9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(Dimensions.space14),
                                child: DefaultText(
                                  text: MyStrings.yourGameWillStartSoon.tr,
                                  fontSize: Dimensions.fontExtraLarge,
                                  textStyle: boldLarge.copyWith(fontStyle: FontStyle.italic),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(Dimensions.space14),
                                child: DefaultText(
                                  text: "${controller.countdownSeconds < 1 ? MyStrings.started.tr : controller.countdownSeconds}",
                                  fontSize: Dimensions.fontExtraLarge * 3,
                                  textStyle: boldLarge.copyWith(color: MyColor.primaryColor, fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink())
              ],
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space25),
                  child: controller.battleRoomController.userFoundState.value == UserFoundState.found && controller.battleRoomController.battleQuestionsList.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                              text: MyStrings.start.tr,
                              press: () {
                                debugPrint("go");

                                controller.battleRoomController.startBattleQuiz(controller.battleRoomController.battleRoomData.value!.roomId, "battle", readyToPlay: true).whenComplete(() {});
                              },
                              cornerRadius: Dimensions.space10,
                              textSize: Dimensions.space20,
                            ),
                          ],
                        )
                      : RoundedButton(
                          text: MyStrings.start.tr,
                          press: () {},
                          color: MyColor.colorWhite,
                          textColor: MyColor.textColor,
                          textSize: Dimensions.space20,
                        ),
                ))
          ],
        ),
      );
    });
  }
}
