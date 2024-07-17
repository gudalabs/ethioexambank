import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/data/controller/play_different_quizes/fun_n_learn/fun_n_learn_quiz_controller.dart';
import 'package:quiz_lab/view/components/buttons/level_card_button.dart';
import 'package:get/get.dart';

class FunNlearnLifeLinesWidget extends StatefulWidget {
  final int questionIndex;
  const FunNlearnLifeLinesWidget({super.key, required this.questionIndex});

  @override
  State<FunNlearnLifeLinesWidget> createState() => _FunNlearnLifeLinesWidgetState();
}

class _FunNlearnLifeLinesWidgetState extends State<FunNlearnLifeLinesWidget> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FunNlearnQuizController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              controller.makeFiftyFifty(widget.questionIndex);
            },
            child: Visibility(
               visible: !controller.fiftyFifty,
              child: const LevelCardButton(
                // lifelineUsed: controller.showQuestions,
                hasIcon: false,
                height: Dimensions.space75,
                width: Dimensions.space78,
                hasImage: true,
                image: MyImages.fiftyFiftySVG,
              ),
            ),
          ),
          Visibility(
            visible: !controller.audienceVote,
            child: InkWell(
              onTap: () {
                controller.audienceVotes(widget.questionIndex);
              },
              child: LevelCardButton(lifelineUsed: controller.audienceVote, hasIcon: false, height: Dimensions.space75, width: Dimensions.space78, hasImage: true, image: MyImages.groupSVG),
            ),
          ),
          InkWell(
            onTap: () {
              controller.countDownController.restart();
              controller.restartCountDownTimer(widget.questionIndex);
            },
            child: Visibility(
              visible: !controller.restartTimer,
              child: const LevelCardButton(
                  // lifelineUsed: controller.showQuestions,
                  hasIcon: false,
                  height: Dimensions.space75,
                  width: Dimensions.space78,
                  hasImage: true,
                  image: MyImages.timeSVG),
            ),
          ),
          Visibility(
            visible: !controller.flipQuistions,
            child: InkWell(
              onTap: () async {
                controller.flipQuiston(widget.questionIndex);
                debugPrint(controller.flipQuistion);
                controller.flipQuistion = "1";
              },
              child: const LevelCardButton(
                  // lifelineUsed: controller.showQuestions,
                  hasIcon: false,
                  height: Dimensions.space75,
                  width: Dimensions.space78,
                  hasImage: true,
                  image: MyImages.nextSVG),
            ),
          ),
        ],
      ),
    );
  }
}
