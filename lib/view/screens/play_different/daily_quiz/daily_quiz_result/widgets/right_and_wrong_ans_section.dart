import 'package:flutter/material.dart';
import 'package:quiz_lab/core/utils/dimensions.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:quiz_lab/core/utils/my_images.dart';
import 'package:quiz_lab/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';

class RightOrWrongAnsSection extends StatelessWidget {
  final String totalQuestions, correctAnswer, wrongAnswer;
  const RightOrWrongAnsSection({super.key, required this.totalQuestions, required this.correctAnswer, required this.wrongAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                "$correctAnswer / $totalQuestions",
                style: regularDefault.copyWith(
                  color: MyColor.rightAnswerbgColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space1),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.space6), color: MyColor.categoryCardBodyWrongColor),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(MyImages.wrongSvg),
              const SizedBox(
                width: Dimensions.space6,
              ),
              Text(
                "$wrongAnswer / $totalQuestions",
                style: regularDefault.copyWith(color: MyColor.wrongAnsColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
