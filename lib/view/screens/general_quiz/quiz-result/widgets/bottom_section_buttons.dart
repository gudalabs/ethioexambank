import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/data/controller/quiz_questions/quiz_questions_controller.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/my_strings.dart';

class BottomSectionButtons extends StatelessWidget {
  final String title;
  final int id;
  const BottomSectionButtons({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizQuestionsController>(
      builder: (controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: Dimensions.space15, start: Dimensions.space15, end: Dimensions.space15),
            child: RoundedButton(
                text: id != 0 ? MyStrings.nextLevel.tr : MyStrings.home.tr,
                press: () {
                  var idData = id;
                  var titleData = title;
                  idData != 0 ? Get.offAllNamed(RouteHelper.quizQuestionsScreen, arguments: [titleData, idData]) : Get.offAllNamed(RouteHelper.bottomNavBarScreen);
                },
                textSize: Dimensions.space21),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.space15),
            child: RoundedButton(
              text: MyStrings.reviewAnswer.tr,
              press: () {
                Get.toNamed(RouteHelper.reviewAnswerScreen);
              },
              color: MyColor.colorBlack,
              textSize: Dimensions.space21,
            ),
          )
        ],
      ),
    );
  }
}
