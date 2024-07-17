import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:quiz_lab/data/repo/play_different_quizes/fun_n_learn/fun_n_learn_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/app-bar/custom_category_appbar.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/no_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../environment.dart';
import '../../../components/dialog/warning_dialog.dart';
import '../../../components/image_widget/my_image_widget.dart';
import '../../../components/mobile_ads/quiz_banner_ads_widget.dart';

class FunNlearnQuizScreen extends StatefulWidget {
  const FunNlearnQuizScreen({super.key});

  @override
  State<FunNlearnQuizScreen> createState() => _FunNlearnQuizScreenState();
}

class _FunNlearnQuizScreenState extends State<FunNlearnQuizScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FunNLearnRepo(apiClient: Get.find()));

    FunNlearnQuizController controller = Get.put(FunNlearnQuizController(
      funNLearnRepo: Get.find(),
    ));

    controller.title = Get.arguments[0];
    controller.quizInfoID = Get.arguments[1];

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFunNlearnQuestions(controller.quizInfoID.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        const WarningAlertDialog().warningAlertDialog(Get.context!, () {
          Get.back();
          Get.offAllNamed(RouteHelper.bottomNavBarScreen);
        });

        return false;
      },
      child: GetBuilder<FunNlearnQuizController>(
        builder: (controller) => Scaffold(
          appBar: CustomCategoryAppBar(title: MyStrings.letsPlay.tr),
          body: controller.loading ?
          const CustomLoader() :
          controller.questionList.isEmpty
          ? const NoDataWidget()
          : Stack(
              fit: StackFit.expand,
              children: [
                PageView(onPageChanged: (value) {}, children: [
                  PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int page) {
                      controller.changePage(page);
                    },
                    itemCount: controller.questionList.length,
                    itemBuilder: (context, questionsIndex) {
                      controller.setCurrentOption(questionsIndex);

                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(Dimensions.space20),
                        child: Stack(
                          children: [
                            Container(
                              key: ValueKey<int>(controller.currentQuestionIndex),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                              padding: const EdgeInsets.all(Dimensions.space15),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      LevelCardButton(isQuestionCount: true ,text: "${controller.currentPage + 1} / ${controller.questionList.length.toString()}", hasIcon: false, hasImage: false),
                                    ],
                                  ),

                                  if (controller.questionList[questionsIndex].image != null) ...[
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                      child: MyImageWidget(
                                        boxFit: BoxFit.contain,
                                        height: Get.width / 2,
                                        imageUrl: "${UrlContainer.questionImagePath}/${controller.questionList[questionsIndex].image}",
                                      ),
                                    ),
                                  ],
                                  Container(padding: const EdgeInsetsDirectional.only(top: Dimensions.space25), child: Text(controller.questionList[questionsIndex].question!, style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                                  const SizedBox(height: Dimensions.space25),
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.questionList[questionsIndex].options!.length,
                                    itemBuilder: (BuildContext context, int optionIndex) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (controller.questionList[questionsIndex].selectedOptionId!.isNotEmpty) {
                                                      return;
                                                    }

                                                    controller.selectAnswer(optionIndex, questionsIndex);

                                                    if (controller.funNLearnRepo.apiClient.getSoundStatus()) {
                                                      controller.questionList[questionsIndex].selectedOptionId!.isEmpty
                                                          ? null
                                                          : controller.selectedOptionIndex == optionIndex
                                                              ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                  ? AudioPlayer().play(AssetSource('audios/correct_ans.mp3'))
                                                                  : AudioPlayer().play(AssetSource('audios/wrong_ans.mp3'))
                                                              : null;
                                                    }
                                                    await Future.delayed(const Duration(milliseconds: 1300));

                                                    if (controller.pageController.page! < controller.questionList.length - 1) {
                                                      controller.pageController.nextPage(
                                                        duration: const Duration(milliseconds: 500),
                                                        curve: Curves.easeInOut,
                                                      );
                                                    }
                                                    if (controller.selectedOptionIndex.toString() == "0" && controller.selectedOptionIndex.toString() == "1") {
                                                      controller.selectedQuestionsId.add(controller.questionList[questionsIndex].id);
                                                    }
                                                    controller.selectedAnswerId.add(controller.questionList[questionsIndex].selectedOptionId);

                                                    if (questionsIndex == controller.questionList.length - 1) {
                                                      controller.submitAnswer();
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets.all(Dimensions.space8),
                                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                                                    decoration: BoxDecoration(
                                                        color: controller.questionList[questionsIndex].selectedOptionId!.isEmpty
                                                            ? MyColor.transparentColor
                                                            : controller.selectedOptionIndex == optionIndex
                                                                ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                    ? MyColor.rightAnswerbgColor
                                                                    : MyColor.wrongAnsColor
                                                                : MyColor.transparentColor,
                                                        borderRadius: BorderRadius.circular(Dimensions.space8),
                                                        border: Border.all(color: controller.questionList[questionsIndex].selectedOptionId!.isNotEmpty && controller.selectedOptionIndex == optionIndex?Colors.transparent : MyColor.colorLightGrey,width: .8)),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(width: Dimensions.space8),
                                                        Expanded(
                                                          child: Text(
                                                            controller.questionList[questionsIndex].options![optionIndex].option.toString(),
                                                            style: regularMediumLarge.copyWith(
                                                                color: controller.questionList[questionsIndex].selectedOptionId!.isEmpty
                                                                    ? MyColor.textColor
                                                                    : controller.selectedOptionIndex == optionIndex
                                                                        ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                            ? MyColor.colorWhite
                                                                            : MyColor.colorWhite
                                                                        : MyColor.textColor),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions.space10,
                                                          child: controller.questionList[questionsIndex].selectedOptionId!.isEmpty ? const SizedBox.shrink() : SvgPicture.asset(controller.isValidAnswer(questionsIndex, optionIndex) ? MyImages.whiteTikSVG : MyImages.wrongAnswerSVG, fit: BoxFit.cover),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              controller.audienceVote == true && controller.audienceVoteIndex == questionsIndex ? Text(MyStrings.fifteenPercent.tr, style: semiBoldExtraLarge.copyWith(color: MyColor.colorQuizBodyAudText)) : const SizedBox()
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                  const SizedBox(height: Dimensions.space25),
                                  // LifeLinesWidget(questionIndex: questionsIndex),
                                  const SizedBox(height: Dimensions.space25),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .4),
                              child: CircularCountDownTimer(
                                duration:controller.timerDuration,
                                initialDuration: 0,
                                controller: controller.countDownController,
                                width: Dimensions.space60,
                                height: Dimensions.space80,
                                ringColor: MyColor.primaryColor,
                                ringGradient: null,
                                fillColor: MyColor.timerbgColor,
                                fillGradient: null,
                                backgroundColor: MyColor.timerbgColor,
                                strokeWidth: Dimensions.space5,
                                strokeCap: StrokeCap.round,
                                textStyle: semiBoldExtraLarge.copyWith(color: MyColor.primaryColor),
                                textFormat: CountdownTextFormat.S,
                                isReverse: true,
                                isReverseAnimation: false,
                                isTimerTextShown: true,
                                autoStart: true,
                                onComplete: () {
                                  if (controller.selectedOptionIndex.toString() == "-1") {
                                    controller.selectedQuestionsId.add(controller.questionList[questionsIndex].id);
                                  }

                                  if (questionsIndex == controller.questionList.length - 1) {
                                    controller.submitAnswer();

                                    // Get.toNamed(RouteHelper.funNlearnResultScreen, arguments: MyStrings.quizResult);
                                  } else {
                                    controller.pageController.nextPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ]),

                //Ads Code
                const Visibility(
                  visible: Environment.isShowAdsOnQuizScreen,
                  child:  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(bottom: Dimensions.space10),
                        child: QuizBannerAdsWidget(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
