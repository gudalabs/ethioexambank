import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/battle/battle_room_controller.dart';
import 'package:quiz_lab/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:quiz_lab/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/route/route.dart';
import '../../../../../../../core/utils/url_container.dart';
import '../../../../../../components/dialog/warning_dialog.dart';
import '../../../../../../components/image_widget/my_image_widget.dart';

class LobbyBottomSheet extends StatefulWidget {
  const LobbyBottomSheet({super.key});

  @override
  State<LobbyBottomSheet> createState() => _LobbyBottomSheetState();
}

class _LobbyBottomSheetState extends State<LobbyBottomSheet> {
  bool start = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleRoomController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          const WarningAlertDialog().warningAlertDialog(
            context,
            () async {
              await controller.deleteBattleRoom(controller.battleRoomData.value!.roomId, false).whenComplete(() {
                Get.offAllNamed(RouteHelper.bottomNavBarScreen);
              });
            },
            title: MyStrings.areYouSureYouWantToLeaveThisRoom,
          );

          return false; // Disable back button if `start` is true
        },
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.space8),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.only(top: Dimensions.space8, bottom: Dimensions.space30),
                child: BottomSheetBar(),
              ),
              Container(
                width: double.infinity,
                color: MyColor.lobbycardColor,
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.space30),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: controller.battleRoomData.value!.roomCode!)).then((value) {
                          debugPrint("copied");
                          CustomSnackBar.success(successList: [(MyStrings.copied.tr)]);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space12),
                        decoration: BoxDecoration(
                          color: MyColor.lobbycontColor,
                          border: Border.all(color: MyColor.lobbycontBorderColor, width: .1),
                          borderRadius: BorderRadius.circular(Dimensions.space8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${controller.battleRoomData.value!.roomCode}",
                              style: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
                            ),
                            const SizedBox(width: Dimensions.space5),
                            SvgPicture.asset(
                              MyImages.copySVG,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(Dimensions.space2),
                      padding: const EdgeInsets.all(Dimensions.space10),
                      width: Dimensions.space260,
                      child: Center(
                        child: Text(
                          MyStrings.sharecodeText.tr,
                          textAlign: TextAlign.center,
                          style: regularLarge.copyWith(color: MyColor.textColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.space21,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.lobbycardColor,
                          border: Border.all(
                            color: MyColor.cardBorderColors,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.space6)),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space10),
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.space2),
                              height: Dimensions.space70,
                              width: Dimensions.space70,
                              decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.space100),
                                    child: controller.battleRoomData.value!.user1!.profileUrl == "null" || controller.battleRoomData.value!.user1!.profileUrl.isEmpty
                                        ? Image.asset(
                                            MyImages.defaultAvatar,
                                            fit: BoxFit.cover,
                                            height: Dimensions.space70,
                                            width: Dimensions.space70,
                                          )
                                        : MyImageWidget(
                                            fromProfile: true,
                                            imageUrl: "${UrlContainer.userImagePath}/${controller.battleRoomData.value!.user1!.profileUrl}",
                                            height: Dimensions.space70,
                                            width: Dimensions.space70,
                                          )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.space10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space2),
                            child: Center(
                              child: Text(
                                controller.battleRoomData.value!.user1!.name,
                                textAlign: TextAlign.center,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.colorBlack),
                              ),
                            ),
                          ),
                          Text(
                            MyStrings.creator.tr,
                            textAlign: TextAlign.center,
                            style: regularLarge.copyWith(color: MyColor.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.space21,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.lobbycardColor,
                          border: Border.all(
                            color: MyColor.cardBorderColors,
                          ),
                          borderRadius: BorderRadius.circular(Dimensions.space6)),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space10),
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.space2),
                              height: Dimensions.space70,
                              width: Dimensions.space70,
                              decoration: BoxDecoration(color: MyColor.colorLightGrey, borderRadius: BorderRadius.circular(Dimensions.space100)),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.space100),
                                    child: controller.battleRoomData.value!.user2!.profileUrl == "null" || controller.battleRoomData.value!.user2!.profileUrl.isEmpty
                                        ? Image.asset(
                                            MyImages.defaultAvatar,
                                            fit: BoxFit.cover,
                                            height: Dimensions.space70,
                                            width: Dimensions.space70,
                                          )
                                        : MyImageWidget(
                                            fromProfile: true,
                                            imageUrl: "${UrlContainer.userImagePath}/${controller.battleRoomData.value!.user2!.profileUrl}",
                                            height: Dimensions.space70,
                                            width: Dimensions.space70,
                                          )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.space10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space2),
                            child: Center(
                              child: Text(
                                controller.battleRoomData.value!.user2!.name.isEmpty ? "...." : controller.battleRoomData.value!.user2!.name,
                                textAlign: TextAlign.center,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.colorBlack),
                              ),
                            ),
                          ),
                          Text(
                            MyStrings.player.tr,
                            textAlign: TextAlign.center,
                            style: regularLarge.copyWith(color: MyColor.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.space100),
              controller.userFoundState.value == UserFoundState.found
                  ? RoundedButton(
                      text: MyStrings.start.tr,
                      press: () {
                        setState(() {
                          start = true;
                        });
                        debugPrint("go");

                        controller.startBattleQuiz(controller.battleRoomData.value!.roomId, "battle", readyToPlay: true).whenComplete(() {});
                      },
                      cornerRadius: Dimensions.space10,
                      textSize: Dimensions.space20,
                    )
                  : RoundedButton(
                      text: MyStrings.start.tr,
                      press: () {
                        setState(() {
                          start = true;
                        });
                      },
                      color: MyColor.lobbycardColor,
                      textColor: MyColor.textColor,
                      textSize: Dimensions.space20,
                    )
            ],
          ),
        ),
      );
    });
  }
}
