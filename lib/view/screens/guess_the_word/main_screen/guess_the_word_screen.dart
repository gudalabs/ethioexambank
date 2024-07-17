import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:quiz_lab/data/controller/gesstheword/gess_the_word_Controller.dart';
import 'package:quiz_lab/data/repo/guess_the_word/guess_the_word_repo.dart';
import 'package:quiz_lab/data/services/api_client.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:quiz_lab/view/components/custom_loader/custom_loader.dart';
import 'package:quiz_lab/view/screens/guess_the_word/widget/question_button.dart';
import 'package:get/get.dart';
import '../../../../core/utils/util.dart';
import '../../../components/app-bar/custom_category_appbar.dart';
import '../../../components/image_widget/my_image_widget.dart';
import '../widget/answer_field.dart';

class GuessThewordScreen extends StatefulWidget {
  const GuessThewordScreen({super.key});

  @override
  State<GuessThewordScreen> createState() => _GuessThewordScreenState();
}

class _GuessThewordScreenState extends State<GuessThewordScreen> {

  int id = 0;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    id = Get.arguments as int;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GuessTheWordRepo(apiClient: Get.find()));
    final controller = Get.put(GuessTheWordController(guessTheWordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.clearAllData();
      controller.getQuestion(id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuessTheWordController>(builder: (controller) {
      return Scaffold(
          appBar: CustomCategoryAppBar(
            title: MyStrings.guessTheWord.tr,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : Stack(
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.guessTheWordQuestionList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) {
                        setState(() {
                          currentQuestionIndex = index; // Update the current index
                        });
                      },
                      itemBuilder: (context, questionsIndex) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(Dimensions.space20),
                          child: Stack(
                            children: [
                              Container(
                                key: ValueKey<int>(questionsIndex),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space20), color: MyColor.colorWhite),
                                padding: const EdgeInsets.all(Dimensions.space15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        LevelCardButton(isQuestionCount: true,bgColor: Colors.transparent,hPadding:Dimensions.space12,vPadding:Dimensions.space10,text: ' ${controller.guessTheWordRepo.apiClient.getUserCurrentCoin()} ${MyStrings.coins.tr}', hasIcon: false, hasImage: false),
                                        LevelCardButton(isQuestionCount: true,bgColor: Colors.transparent,hPadding:Dimensions.space12,vPadding:Dimensions.space10,text: " ${questionsIndex + 1}/${controller.guessTheWordQuestionList.length}", hasIcon: false, hasImage: false),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                    // note: use  preloader or something like this
                                    controller.guessTheWordQuestionList[questionsIndex].image != null
                                        ? Container(
                                            margin: const EdgeInsetsDirectional.only(top: Dimensions.space20, bottom: Dimensions.space20),
                                            width: double.infinity,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                                            height: context.width / 2.5,
                                            child: MyImageWidget(
                                              boxFit: BoxFit.contain,
                                              radius: Dimensions.defaultRadius,
                                              imageUrl: "${controller.questionImgPath}/${controller.guessTheWordQuestionList[questionsIndex].image}",
                                            ),
                                          )
                                        : const SizedBox(height: Dimensions.space20),
                                    Container(padding: const EdgeInsetsDirectional.only(top: Dimensions.space20), child: Text(controller.guessTheWordQuestionList[questionsIndex].question.toString(), style: semiBoldExtraLarge.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center)),
                                    const SizedBox(height: Dimensions.space40),
                                    AnswerField(length: controller.guessTheWordQuestionList[questionsIndex].options![0].option!.length),

                                    const SizedBox(height: Dimensions.space30),
                                    GuessWordKeyBoard(
                                      ans: controller.guessTheWordQuestionList[questionsIndex].options![0].option.toString(),
                                    ),
                                    const SizedBox(height: Dimensions.space15),
                                    Align(
                                        alignment: Alignment.center,
                                        child:InkWell(
                                          onTap: (){
                                            controller.removeValue();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(Dimensions.space3),
                                            height: Dimensions.space40,
                                            width: Dimensions.space40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                boxShadow: MyUtils.getBottomSheetShadow(),
                                                border: Border.all(
                                                    color: MyColor.borderColor.withOpacity(.5),
                                                    width: .5
                                                ),
                                                color: MyColor.colorWhite
                                              // color: Colors.transparent
                                              //color: MyColor.lightGray,
                                            ),
                                            child: const Icon(
                                              Icons.delete_forever_outlined,
                                              color: MyColor.primaryColor,
                                            ),
                                          ),
                                        )),
                                    const SizedBox(height: Dimensions.space40),
                                    const SizedBox(height: Dimensions.space40),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .4),
                                child: CircularCountDownTimer(
                                  initialDuration: 0,
                                  duration: controller.ansDuration,
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
                                    controller.addAns(questionsIndex, controller.tempAns.join().toLowerCase().toString());
                                    questionsIndex == controller.guessTheWordQuestionList.length - 1 ? controller.submitGuessTheWordAnswers() : controller.nextPage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 20, // Adjust this value to control the distance from the bottom
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20),
                        child: Center(
                          child: RoundedButton(
                            text: MyStrings.submit.tr,
                            press: () {
                              controller.addAns(currentQuestionIndex, controller.tempAns.join().toLowerCase().toString());
                              if (currentQuestionIndex == controller.guessTheWordQuestionList.length - 1) {
                                controller.submitGuessTheWordAnswers();
                              } else {
                                controller.nextPage();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
    });
  }
}
