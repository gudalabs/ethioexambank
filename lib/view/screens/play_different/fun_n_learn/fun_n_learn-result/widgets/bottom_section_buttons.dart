import 'package:flutter/material.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/model/play_different_quizes/fun_n_learn/fun_n_learn_questions_model.dart';
import 'package:quiz_lab/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

class BottomSectionButtons extends StatelessWidget {
  const BottomSectionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: Dimensions.space15, start: Dimensions.space15, end: Dimensions.space15),
          child: RoundedButton(
              text: MyStrings.reviewAnswer.tr,
              press: () {
                Get.toNamed(RouteHelper.funNlearnResultReviewScreen, arguments: [Get.arguments[0] as List<Question>, Get.arguments[1]]);
              },
              textSize: Dimensions.space21),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.space15),
          child: RoundedButton(
            text: MyStrings.home.tr,
            press: () {
              Get.offAllNamed(RouteHelper.bottomNavBarScreen);
            },
            color: MyColor.colorBlack,
            textSize: Dimensions.space21,
          ),
        )
      ],
    );
  }
}
