import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/quiz_questions/quiz_questions_controller.dart';
import '../../../../../data/repo/quiz_questions_repo/quiz_questions_repo.dart';
import '../../../../../data/services/api_client.dart';
import '../../../../components/divider/custom_dashed_divider.dart';
import 'bottom_section_buttons.dart';
import 'player_profile_picture.dart';
import 'rewards_section.dart';
import 'right_and_wrong_ans_section.dart';

class QuizResultBodySection extends StatefulWidget {
  const QuizResultBodySection({super.key});

  @override
  State<QuizResultBodySection> createState() => _QuizResultBodySectionState();
}

class _QuizResultBodySectionState extends State<QuizResultBodySection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(QuizquestionsRepo(apiClient: Get.find()));

    Get.put(QuizQuestionsController(quizquestionsRepo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          if (int.parse(controller.nextlevelQuizInfoId.toString()) == 0) {
            Get.offAllNamed(RouteHelper.bottomNavBarScreen);
          }
          return true;
        },
        child: Container(
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
              height: Dimensions.space20,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: RightOrWrongAnsSection(correctAnswer: controller.correctAnswer, wrongAnswer: controller.wrongAnswer, totalQuestions: controller.totalQuestions)),
                  Container(
                    margin: const EdgeInsets.all(Dimensions.space10),
                    child: PlayerProfilePicture(
                      imagePath: controller.quizquestionsRepo.apiClient.getUserImagePath(),
                    ),
                  ),
                  Expanded(
                    child: RewardsSection(
                      totalCoin: controller.totalCoin,
                      winningCoin: controller.winningCoin,
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.space40),
                child: CustomDashedDivider(
                  height: Dimensions.space1,
                  width: double.infinity,
                ),
              ),
              BottomSectionButtons(
                title: controller.nextlevelQuizInfoTitle,
                id: int.parse(controller.nextlevelQuizInfoId.toString()),
              )
            ],
          ),
        ),
      );
    });
  }
}
