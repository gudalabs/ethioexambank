import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:quiz_lab/view/components/divider/custom_dashed_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class FunNLearnResultBodySection extends StatefulWidget {
  const FunNLearnResultBodySection({super.key});

  @override
  State<FunNLearnResultBodySection> createState() => _FunNLearnResultBodySectionState();
}

class _FunNLearnResultBodySectionState extends State<FunNLearnResultBodySection> {
  bool showQuestions = false;
  bool audienceVote = false;
  bool tapAnswer = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNlearnQuizController>(
      builder: (controller) => Container(
        margin: const EdgeInsetsDirectional.only(top: Dimensions.space20),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.only(top: Dimensions.space10, start: Dimensions.space8, end: Dimensions.space8),
                  child: controller.appreciation == "Failed"
                      ?Lottie.asset(MyImages.failedLottie,height: 200,width: 200,repeat: false,reverse: false)
                      : Lottie.asset(MyImages.successLottie,height: 200,width: 200,repeat: false,reverse: false)
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child:Column(
                children: [
                  Text(
                    controller.appreciation,
                    textAlign: TextAlign.center,
                    style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space30),
                  ),
                  const SizedBox(
                    height: Dimensions.space10,
                  ),
                  Text(
                    controller.appreciation == "Failed" ? MyStrings.betterLuckNextTime.tr : MyStrings.victory.tr,
                    textAlign: TextAlign.center,
                    style: regularDefault.copyWith(color: MyColor.colorQuizBodyText,fontSize: Dimensions.fontMediumLarge),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.space18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: RightOrWrongAnsSection(correctAnswer: controller.correctAnswer, wrongAnswer: controller.wrongAnswer, totalQuestions: controller.totalQuestions)),
                Container(
                  margin: const EdgeInsets.all(Dimensions.space10),
                  child: PlayerProfilePicture(
                    imagePath: controller.funNLearnRepo.apiClient.getUserImagePath(),
                  ),
                ),
                Expanded(
                  child: ExamRewardsSection(
                    totalCoin: controller.totalCoin,
                    winningCoin: controller.winningCoin,
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.space50),
              child: CustomDashedDivider(
                height: Dimensions.space1,
                width: double.infinity,
              ),
            ),
            const BottomSectionButtons()
          ],
        ),
      ),
    );
  }
}
