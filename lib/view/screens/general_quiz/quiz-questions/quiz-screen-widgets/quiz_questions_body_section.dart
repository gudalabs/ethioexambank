import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/core/utils/url_container.dart';
import 'package:quiz_lab/environment.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/components/dialog/warning_dialog.dart';
import 'package:quiz_lab/view/components/no_data.dart';

import '../../../../../data/controller/quiz_questions/quiz_questions_controller.dart';
import '../../../../components/image_widget/my_image_widget.dart';
import 'life_line_widget.dart';

class QuizBodySection extends StatefulWidget {
  const QuizBodySection({super.key});

  @override
  State<QuizBodySection> createState() => _QuizBodySectionState();
}

class _QuizBodySectionState extends State<QuizBodySection> {
  @override
  void initState() {
    super.initState();


  }

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(builder: (controller) {
      return controller.isLoading
      ? const CustomLoader()
      : controller.questionsList.isEmpty
          ? const SingleChildScrollView(child: NoDataWidget())
          : WillPopScope(
              onWillPop: () async {
                const WarningAlertDialog().warningAlertDialog(context, () {
                  Get.offAllNamed(RouteHelper.bottomNavBarScreen);
                });
                return false; // Disable back button if `start` is true
              },
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: (int page) {
                  controller.changePage(page);
                },
                itemCount: controller.questionsList.length,
                itemBuilder: (context, questionsIndex) {
                  controller.setCurrentOption(questionsIndex);
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                                  LevelCardButton(isQuestionCount:true,text: "${controller.currentPage + 1} / ${controller.questionsList.length.toString()}", hasIcon: false, hasImage: false),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space25),
                              if (controller.questionsList[questionsIndex].image != null) ...[
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius)
                                  ),
                                  padding: const EdgeInsetsDirectional.only(top: Dimensions.space40, start: Dimensions.space8, end: Dimensions.space8),
                                  child: MyImageWidget(
                                    boxFit: BoxFit.contain,
                                    radius: Dimensions.defaultRadius,
                                    height: Get.width / 2,
                                    imageUrl: "${UrlContainer.questionImagePath}/${controller.questionsList[questionsIndex].image}",
                                  ),
                                ),
                              ],
                              Container(padding: const EdgeInsetsDirectional.only(top: Dimensions.space20), child: Text(controller.questionsList[questionsIndex].question!, style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                              const SizedBox(height: Dimensions.space25),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.questionsList[questionsIndex].options?.length ?? 0,
                                itemBuilder: (BuildContext context, int optionIndex) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                if (controller.questionsList[questionsIndex].selectedOptionId!.isNotEmpty) {
                                                  return;
                                                }

                                                controller.selectAnswer(optionIndex, questionsIndex);

                                                if (controller.quizquestionsRepo.apiClient.getSoundStatus()) {
                                                  controller.selectedOptionIndex == optionIndex
                                                      ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                          ? AudioPlayer().play(AssetSource('audios/correct_ans.mp3'))
                                                          : AudioPlayer().play(AssetSource('audios/wrong_ans.mp3'))
                                                      : null;
                                                }

                                                await Future.delayed(const Duration(seconds: 1));

                                                if (controller.pageController.page! < controller.questionsList.length - 1) {
                                                  controller.pageController.nextPage(
                                                    duration: const Duration(milliseconds: 500),
                                                    curve: Curves.easeInOut,
                                                  );
                                                  controller.showaudienceVote = false;
                                                }
                                                if (controller.selectedOptionIndex.toString() == "0" && controller.selectedOptionIndex.toString() == "1") {
                                                  controller.selectedQuestionsId.add(controller.questionsList[questionsIndex].id);
                                                }
                                                controller.selectedAnswerId.add(controller.questionsList[questionsIndex].selectedOptionId);

                                                if (questionsIndex == controller.questionsList.length - 1) {
                                                  controller.submitAnswer();
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.all(Dimensions.space8),
                                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                                                decoration: BoxDecoration(
                                                    color: controller.questionsList[questionsIndex].selectedOptionId!.isEmpty
                                                        ? MyColor.transparentColor
                                                        : controller.selectedOptionIndex == optionIndex
                                                            ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                ? MyColor.rightAnswerbgColor
                                                                : MyColor.wrongAnsColor
                                                            : MyColor.transparentColor,
                                                    borderRadius: BorderRadius.circular(Dimensions.space8),
                                                    border: Border.all(color:  controller.questionsList[questionsIndex].selectedOptionId!.isNotEmpty && controller.selectedOptionIndex == optionIndex ? Colors.transparent :  MyColor.colorLightGrey ,width: .8)),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "${Environment.isShowQuestionPrefix? "${MyStrings.questionPrefix[optionIndex]})" : ""} ${controller.questionsList[questionsIndex].options![optionIndex].option.toString()} ",
                                                        overflow: TextOverflow.visible,
                                                        style: regularMediumLarge.copyWith(
                                                            color: controller.questionsList[questionsIndex].selectedOptionId!.isEmpty
                                                                ? MyColor.textColor
                                                                : controller.selectedOptionIndex == optionIndex
                                                                    ? controller.isValidAnswer(questionsIndex, optionIndex)
                                                                        ? MyColor.colorWhite
                                                                        : MyColor.colorWhite
                                                                    : MyColor.textColor
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: Dimensions.space10, child: controller.questionsList[questionsIndex].selectedOptionId!.isEmpty ? const SizedBox.shrink() : SvgPicture.asset(controller.isValidAnswer(questionsIndex, optionIndex) ? MyImages.whiteTikSVG : MyImages.wrongAnswerSVG, fit: BoxFit.cover))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // const Spacer(),
                                          controller.showaudienceVote == true && controller.audienceVoteIndex == questionsIndex
                                              ? Text(
                                                  "${controller.questionsList[questionsIndex].playedAudience == '0' ? "0.00" : controller.calculateAudienceVotes(controller.questionsList[questionsIndex].options![optionIndex].audience.toString(), controller.questionsList[questionsIndex].playedAudience.toString())}${MyStrings.percent.tr}",
                                                  style: regularMediumLarge.copyWith(color: MyColor.textColor),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              const SizedBox(height: Dimensions.space25),
                              LifeLinesWidget(questionIndex: questionsIndex),
                              const SizedBox(height: Dimensions.space60),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .4),
                          child: CircularCountDownTimer(
                            duration: controller.timerDuration,
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
                                controller.selectedQuestionsId.add(controller.questionsList[questionsIndex].id);
                              }
                              // controller.selectedOptionIndex.toString().isNotEmpty ? debugPrint("this is selectedoption index" + controller.selectedOptionIndex.toString()) : print;
                              if (questionsIndex == controller.questionsList.length - 1) {
                                controller.submitAnswer();
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
            );
    });
  }
}
