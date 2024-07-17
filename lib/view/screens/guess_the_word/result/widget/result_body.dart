import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/divider/custom_horizontal_divider.dart';
import 'package:quiz_lab/view/components/divider/custom_vertical_divider.dart';
import 'package:get/get.dart';

import '../../../../../data/model/guess_the_word/guess_question_model.dart';

class GuessResultBody extends StatefulWidget {
  const GuessResultBody({super.key});

  @override
  State<GuessResultBody> createState() => _GuessResultBodyState();
}

class _GuessResultBodyState extends State<GuessResultBody> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessTheWordController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space30),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  controller.totalScore,
                  style: mediumOverLarge,
                ),
                const SizedBox(
                  height: Dimensions.space2,
                ),
                Text(
                  MyStrings.totalScore.tr,
                  style: lightDefault,
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.space40 - 20,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.only( start: Dimensions.space8, end: Dimensions.space8),
                  child: controller.appreciation == "[Failed]"
                      ?Lottie.asset(MyImages.failedLottie,height: 200,width: 200,repeat: false,reverse: false)
                      : Lottie.asset(MyImages.successLottie,height: 200,width: 200)
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.space10,
            ),
            Text("${controller.appreciation.replaceAll("[", "").replaceAll("]", "")} ", style: semiBoldExtraLarge.copyWith(fontSize: Dimensions.fontExtraLarge)),
            const SizedBox(
              height: Dimensions.space20,
            ),
            // const CustomDashedDivider(height: 1, width: double.infinity),
            const CustomHorizontalDivider(),
            const SizedBox(
              height: Dimensions.space20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Column(
                      children: [
                        Text(
                          controller.totalQuestion,
                          style: mediumLarge,
                        ),
                        const SizedBox(
                          height: Dimensions.space5,
                        ),
                        Text(
                          MyStrings.totalQuestion.tr,
                          textAlign: TextAlign.center,
                          style: lightDefault,
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomVerticalDivider(
                  height: Dimensions.space20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Column(
                      children: [
                        Text(
                          controller.correctAnswer,
                          style: mediumLarge,
                        ),
                        const SizedBox(
                          height: Dimensions.space5,
                        ),
                        Text(
                          MyStrings.correctAnswer.tr,
                          textAlign: TextAlign.center,
                          style: lightDefault.copyWith(color: MyColor.greenSuccessColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomVerticalDivider(
                  height: Dimensions.space20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Column(
                      children: [
                        Text(
                          controller.wrongAnswer.toString(),
                          style: mediumLarge,
                        ),
                        const SizedBox(
                          height: Dimensions.space5,
                        ),
                        Text(
                          MyStrings.wrongAnswer.tr,
                          textAlign: TextAlign.center,
                          style: lightDefault.copyWith(color: MyColor.redCancelTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.space40,
            ),
            RoundedButton(
                text: MyStrings.playAgain.tr,
                press: () {
                  Get.offAndToNamed(RouteHelper.guessTheword, arguments: int.parse(controller.quizInfoId.toString()));
                },
                textSize: Dimensions.space21),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.reviewAnswer.tr,
              press: () {
                Get.offAndToNamed(RouteHelper.gessThewordResultReview, arguments: [controller.guessTheWordQuestionList.isNotEmpty ? controller.guessTheWordQuestionList : <GuessQuestion>[]]);
              },
              color: MyColor.greenSuccessColor,
              textSize: Dimensions.space21,
            ),
            const SizedBox(
              height: Dimensions.space20,
            ),
            RoundedButton(
              text: MyStrings.home.tr,
              press: () {
                Get.offAllNamed(RouteHelper.bottomNavBarScreen);
              },
              color: MyColor.colorBlack,
              textSize: Dimensions.space21,
            ),
          ],
        ),
      );
    });
  }
}
