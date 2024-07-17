import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/data/controller/battle/battle_result_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/repo/battle/battle_repo.dart';
import '../../../../data/services/api_client.dart';
import '../../../components/divider/custom_dashed_divider.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_details.dart';

class BattleQuizResultBodySection extends StatefulWidget {
  const BattleQuizResultBodySection({super.key});

  @override
  State<BattleQuizResultBodySection> createState() => _BattleQuizResultBodySectionState();
}

class _BattleQuizResultBodySectionState extends State<BattleQuizResultBodySection> {
  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BattleRepo(apiClient: Get.find()));
    Get.put(BattleResultController(Get.find()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleResultController>(initState: (state) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (state.controller!.messageStatus.contains('Congratulations') || state.controller!.messageStatus.contains('Draw')) {
          state.controller!.confettiControllerTopCenter.play();
        }
      });
    }, builder: (controller) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsetsDirectional.only(top: Dimensions.space50, bottom: Dimensions.space50, start: Dimensions.space15, end: Dimensions.space15),
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.space20),
            color: MyColor.colorWhite,
          ),
          child: Stack(
            children: [
              if (controller.messageStatus.contains('Congratulations') || controller.messageStatus.contains('Draw')) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space8, end: Dimensions.space8),
                  child: SvgPicture.asset(
                    MyImages.victory,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsetsDirectional.only(top: Dimensions.space10),
                          margin: const EdgeInsetsDirectional.only(top: Dimensions.space30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("${controller.messageStatus}"),
                              if (controller.messageStatus.contains('Congratulations') == true) ...[
                                Text(
                                  MyStrings.victory.tr,
                                  textAlign: TextAlign.center,
                                  style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                                ),
                                const SizedBox(
                                  height: Dimensions.space10,
                                ),
                                Text(
                                  MyStrings.congratulation.tr,
                                  textAlign: TextAlign.center,
                                  style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText, fontSize: Dimensions.fontLarge),
                                )
                              ] else if (controller.messageStatus.contains('Draw') == true) ...[
                                Text(
                                  MyStrings.drawn.tr,
                                  textAlign: TextAlign.center,
                                  style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                                ),
                                const SizedBox(
                                  height: Dimensions.space10,
                                ),
                                Text(
                                  MyStrings.congratulation.tr,
                                  textAlign: TextAlign.center,
                                  style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText, fontSize: Dimensions.fontLarge),
                                )
                              ] else ...[
                                Text(
                                  MyStrings.defeat.tr,
                                  textAlign: TextAlign.center,
                                  style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                                ),
                                const SizedBox(
                                  height: Dimensions.space10,
                                ),
                                Text(
                                  MyStrings.betterLuckNextTime.tr,
                                  textAlign: TextAlign.center,
                                  style: regularOverLarge.copyWith(color: MyColor.colorQuizBodyText, fontSize: Dimensions.fontLarge),
                                )
                              ],
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.space30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.space10),
                          child: Column(
                            children: [
                              PlayerProfileDetails(userData: controller.myUserInfoData),
                              const SizedBox(
                                height: Dimensions.space20,
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
                                // margin: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(MyImages.greenTikSvg),
                                    const SizedBox(width: Dimensions.space6),
                                    Text(
                                      "${controller.correctAnswer}/${controller.totalQuestion}",
                                      style: regularDefault.copyWith(
                                        color: MyColor.rightAnswerbgColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //opponents
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.space10),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                if (controller.argumentsResult.data["opponent"] != null) ...[
                                  PlayerProfileDetails(
                                    userData: controller.argumentsResult.data["opponent"],
                                  ),
                                  const SizedBox(
                                    height: Dimensions.space20,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyColor),
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(MyImages.greenTikSvg),
                                        const SizedBox(width: Dimensions.space6),
                                        Text(
                                          "${controller.opponentCorrectAnswer}/${controller.totalQuestion}",
                                          style: regularDefault.copyWith(
                                            color: MyColor.rightAnswerbgColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.space20),
                    child: CustomDashedDivider(
                      height: Dimensions.space1,
                      width: double.infinity,
                      strokeWidth: 1,
                    ),
                  ),
                  const BottomSectionButtons(),
                  const SizedBox(
                    height: Dimensions.space15,
                  )
                ],
              ),

              //CENTER -- Blast
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: controller.confettiControllerTopCenter,
                  blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                  shouldLoop: true, // start again as soon as the animation is finished
                  colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple], // manually specify the colors to be used
                  createParticlePath: drawStar, // define a custom shape/path.
                ),
              ),
              //TOP CENTER - shoot Up
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConfettiWidget(
                    confettiController: controller.confettiControllerTopCenter,
                    blastDirection: -pi / 2,
                    emissionFrequency: 0.01,
                    numberOfParticles: 20,
                    maxBlastForce: 100,
                    minBlastForce: 80,
                    gravity: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

/// A custom Path to paint stars.
Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}
